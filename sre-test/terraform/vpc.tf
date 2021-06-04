data "aws_availability_zones" "available" {}

resource "aws_vpc" "vpc" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags {
    name        = "${var.app_name}-${var.environment}-vpc"
    environment = "${var.environment}"
    managed_by  = "${var.managed_by}"
  }
}

resource "aws_internet_gateway" "ig" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    name        = "${var.app_name}-${var.environment}-ig"
    environment = "${var.environment}"
    managed_by  = "${var.managed_by}"
  }
}

resource "aws_eip" "nat" {
  count = "${var.az_count}"
  vpc   = true
}

resource "aws_nat_gateway" "gw" {
  count         = "${var.az_count}"
  subnet_id     = "${element(aws_subnet.public.*.id, count.index)}"
  allocation_id = "${element(aws_eip.nat.*.id, count.index)}"
}

resource "aws_subnet" "public" {
  count                   = "${var.az_count}"
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${cidrsubnet(aws_vpc.vpc.cidr_block, 8, count.index)}"
  availability_zone       = "${data.aws_availability_zones.available.names[count.index]}"
  map_public_ip_on_launch = false

  tags {
    name        = "${var.app_name}-${var.environment}-public-subnet-${count.index}"
    environment = "${var.environment}"
    managed_by  = "${var.managed_by}"
  }
}

resource "aws_subnet" "private" {
  count                   = "${var.az_count}"
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${cidrsubnet(aws_vpc.vpc.cidr_block, 8, count.index + 100)}"
  availability_zone       = "${data.aws_availability_zones.available.names[count.index]}"
  map_public_ip_on_launch = false

  tags {
    name        = "${var.app_name}-${var.environment}-private-subnet-${count.index}"
    environment = "${var.environment}"
    managed_by  = "${var.managed_by}"
  }
}

resource "aws_route_table" "public" {
  count  = "${var.az_count}"
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.ig.id}"
  }

  tags {
    name        = "${var.app_name}-${var.environment}-public-routes"
    environment = "${var.environment}"
    managed_by  = "${var.managed_by}"
  }
}

resource "aws_route_table" "private" {
  count  = "${var.az_count}"
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${element(aws_nat_gateway.gw.*.id, count.index)}"
  }

  tags {
    name        = "${var.app_name}-${var.environment}-private-routes"
    environment = "${var.environment}"
    managed_by  = "${var.managed_by}"
  }
}

resource "aws_route_table_association" "public" {
  count          = "${var.az_count}"
  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.public.*.id, count.index)}"
}

resource "aws_route_table_association" "private" {
  count          = "${var.az_count}"
  subnet_id      = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.private.*.id, count.index)}"
}
