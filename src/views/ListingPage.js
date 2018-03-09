import React from 'react';
import ListingPageItem from './ListingPageItem';
import '../stylesheets/ListingPage.scss';

const ListingPage = ({ data, isLoading, error }) => {
    if (error) {
        return <p className="message">{error.message}</p>;
    }

    if (isLoading) {
        return <p className="message">Loading ...</p>;
    }

    const items = data || [];

    return (
        <main className="ListingPage">
            {items.map(item =>
                <ListingPageItem item={item} key={item.id} />
            )}
        </main>
    );
};

export default ListingPage;
