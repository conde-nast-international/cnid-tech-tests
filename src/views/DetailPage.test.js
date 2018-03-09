import React from 'react';
import { shallow } from 'enzyme';
import DetailPage from './DetailPage';

const article = {
    "id": 0,
    "title": "Lorem Ipsum is simply dummy text of the printing and typesetting industry",
    "body": [{
        "type": "plaintext",
        "body": "Frankfurter turducken sausage, landjaeger strip steak tail alcatra. Filet mignon kielbasa brisket tail biltong ham cow. Sausage beef ribs picanha flank chicken, boudin capicola pork loin salami ball tip swine bresaola pig andouille rump. T-bone cupim swine andouille brisket. Pastrami t-bone sausage short loin alcatra porchetta andouille pancetta landjaeger. Frankfurter chicken pork loin, spare ribs sirloin pig picanha rump meatloaf. Venison t-bone sirloin corned beef, cupim tail pastrami capicola tongue landjaeger beef."
    }, {
        "type": "plaintext",
        "body": "Cold-pressed VHS aesthetic YOLO, cray pop-up squid lo-fi swag direct trade. Drinking vinegar yuccie everyday carry kale chips. Hoodie ennui four dollar toast synth, occupy chillwave marfa affogato microdosing pour-over hashtag aesthetic. YOLO mixtape quinoa irony, sartorial vice wolf. Sriracha meh pug polaroid brooklyn, everyday carry blog. Small batch poutine portland mixtape dreamcatcher. Ramps helvetica mlkshk skateboard vinyl, pour-over everyday carry schlitz jean shorts food truck celiac."
    }, {"type": "h2", "body": "I hacked the Pentagon and all I got was this stupid t-shirt"}, {
        "type": "h2",
        "body": "You people wonder why I'm still single?"
    }, {
        "type": "plaintext",
        "body": "Landjaeger pork pastrami, doner bresaola jerky cupim cow. Biltong ham beef meatloaf, corned beef turkey landjaeger pork loin t-bone hamburger swine pork belly flank ground round. Pork belly pig meatloaf jowl short loin filet mignon, frankfurter porchetta brisket alcatra. Meatball landjaeger capicola pancetta prosciutto pork loin short ribs t-bone flank turkey short loin biltong shank pastrami tri-tip. Swine frankfurter pork, rump t-bone jowl hamburger brisket. Prosciutto boudin pork, short loin kevin ball tip pork loin spare ribs cupim brisket filet mignon."
    }, {
        "type": "pull_quote",
        "body": "If one examines the postdeconstructive paradigm of expression, one is faced with a choice: either accept modernist rationalism or conclude that expression is created by the masses."
    }, {
        "type": "plaintext",
        "body": "YOLO yr disrupt farm-to-table. Selvage listicle drinking vinegar, VHS cliche pug pinterest leggings before they sold out intelligentsia. Post-ironic next level schlitz retro butcher, gochujang put a bird on it normcore. Single-origin coffee knausgaard selfies kale chips slow-carb stumptown, photo booth sustainable tote bag fixie health goth seitan occupy. Twee hammock chia, raw denim drinking vinegar blog fanny pack poutine. Fanny pack authentic gluten-free taxidermy, chartreuse echo park hashtag shabby chic vinyl portland you probably haven't heard of them sartorial flannel. Cronut photo booth church-key next level."
    }],
    "cover": "https://s3-eu-west-1.amazonaws.com/cnid-tech-test/1.jpg",
    "url": "https://s3-eu-west-1.amazonaws.com/cnid-tech-test/1.jpg"
};

describe('DetailPage', () => {
    describe('@render', () => {
        test('has error message', () => {
            const error = {
                message: "Test error"
            };
            const item = shallow(<DetailPage error={error} />);
            expect(item.find('.message')).toHaveLength(1);
            expect(item.find('.message').text()).toEqual('Test error');
        });

        test('has loading message', () => {
            const item = shallow(<DetailPage isLoading={true} />);
            expect(item.find('.message')).toHaveLength(1);
            expect(item.find('.message').text()).toEqual('Loading ...');
        });

        test('has image', () => {
            const item = shallow(<DetailPage data={article}/>);
            expect(item.find('.DetailPage-image img')).toHaveLength(1);
            expect(item.find('.DetailPage-image img').props().src).toEqual(article.cover);
        });

        test('has title', () => {
            const item = shallow(<DetailPage data={article}/>);
            expect(item.find('.DetailPage-title')).toHaveLength(1);
            expect(item.find('.DetailPage-title').text()).toEqual(article.title);
        });

        test('has plaintext elements', () => {
            const item = shallow(<DetailPage data={article}/>);
            expect(item.find('.DetailPage p')).toHaveLength(4);
        });

        test('has h2 elements', () => {
            const item = shallow(<DetailPage data={article}/>);
            expect(item.find('.DetailPage h2')).toHaveLength(2);
        });

        test('has a pull quote', () => {
            const item = shallow(<DetailPage data={article}/>);
            expect(item.find('.DetailPage blockquote')).toHaveLength(1);
        });
    });
});
