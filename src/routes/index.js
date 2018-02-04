import React from 'react';
import { Router, Route, hashHistory } from 'react-router';

import ListingPage from '../views/ListingPage';
import DetailPage from '../views/DetailPage';
import PageNotFound from '../views/PageNotFound';
import withFetching from '../components/WithFetching';

export default (
    <Router history={hashHistory}>
        <Route path="/" component={withFetching('/api/articles')(ListingPage)}/>
        <Route path="/article/:articleId" component={withFetching()(DetailPage)}/>
        <Route path="*" exact={true} component={PageNotFound}/>
    </Router>
);