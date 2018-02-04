import React from 'react';
import _ from 'lodash';
import '../stylesheets/DetailPage.scss';

const DetailPage = ({ data, isLoading, error }) => {
    if (error) {
        return <p className="message">{error.message}</p>;
    }

    if (isLoading) {
        return <p className="message">Loading ...</p>;
    }

    const item = data ? data : undefined;
    const itemBody = _.isEmpty(item) ? null : item.body.map((element, index) => {
        switch (element.type) {
            case 'plaintext':
                return <p key={index}>{element.body}</p>;
                break;
            case 'h2':
                return <h2 key={index}>{element.body}</h2>;
                break;
            case 'pull_quote':
                return <blockquote key={index}>{element.body}</blockquote>;
                break;
        }
    });

    return (
        <article className="DetailPage">
            { item && <div className="DetailPage-content">
                <section className="DetailPage-header">
                    <div className="DetailPage-image">
                        <img src={item.cover} />
                    </div>
                    <h1 className="DetailPage-title">{item.title}</h1>
                </section>
                <section className="DetailPage-body">
                    {itemBody}
                </section>
            </div> }
        </article>
    );
};

export default DetailPage;
