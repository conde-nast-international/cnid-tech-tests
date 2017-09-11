const request = require('supertest');
const express = require('express');
const app = require('../app');

describe('GET /', function() {
  it('respond with 200', function(done) {
    request(app)
      .get('/')
      .set('Accept', 'text/html')
      .expect(200, done);
  });
});

describe('GET /article/0', function() {
  it('respond with 200', function(done) {
    request(app)
      .get('/article/0')
      .set('Accept', 'text/html')
      .expect(200)
      .expect(validContent)
      .end(done);
  });
});

function validContent(res) {
  if(!res.text.includes('Lorem Ipsum is simply dummy text of the printing and typesetting industry')) {
    throw new Error('Missing content');
  }
}
