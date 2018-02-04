import React from 'react';
import { Link } from 'react-router';
import '../stylesheets/ListingPageItem.scss';

const ListingPageItem = ({ item }) => {
  return (
      <article className="ListingPageItem">
          <Link className="ListingPageItem-link" to={`/article/${item.id}`}>
              <img className="ListingPageItem-image" src={item.cover} />
              <h1 className="ListingPageItem-title">{item.title}</h1>
          </Link>
      </article>
  );
};

export default ListingPageItem;
