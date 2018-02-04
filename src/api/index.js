import ListingPageController from './controllers/ListingPageController';
import DetailPageController from './controllers/DetailPageController';

export default (app) => {
    app.get('/api/articles', ListingPageController);
    app.get('/api/article/:articleId', DetailPageController);

    return app;
};