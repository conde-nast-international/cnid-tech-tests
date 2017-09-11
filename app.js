const express  = require('express'),
      articles = require('./data/article.json')
      server   = express();

/* Set view engine to Pug */
server.set('view engine', 'pug');

/* Tell Express to serve the public folder */
server.use(express.static('public'));

/* Route Setup */
/* Root route */
server.get('/', (req, res) => {
    /* Pass articles to index to render */
    res.render('index', { articles });
});

/* Article route */
server.get('/article/:articleId', (req, res) => {
    /* Pass single article to article view to render */
    res.render('article', { article: getArticle(req.params.articleId) });
});

/* Broadcast server */
server.listen(3000, () => {
  console.log('CNID Tech Test broadcasting on port 3000');
});

/* Helper functions */
/* Get article by ID */
function getArticle(articleId) {
    for (let i = articles.length - 1; i >= 0; i--) {
        if(articles[i].id == articleId) {
            return articles[i];
        }
    }
}

module.exports = server; /* Required for testing */
