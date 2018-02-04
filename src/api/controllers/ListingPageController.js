import fs from 'fs';
import path from 'path';

const ListingPageController = (req, res) => {
    fs.readFile((path.resolve(__dirname, '../data/articles.json')), (err, resp) => {
        if (err) {
            res.status(500).send('Something went wrong');
        }

        res.send(resp);
    });
};

export default ListingPageController;