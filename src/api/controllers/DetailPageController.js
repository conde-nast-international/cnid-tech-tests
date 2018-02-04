import fs from 'fs';
import path from 'path';

const DetailPageController = (req, res) => {
    fs.readFile((path.resolve(__dirname, '../data/articles.json')), (err, resp) => {
        const articles = JSON.parse(resp);
        if (err || !articles.length) {
            res.status(500).send('Something went wrong');
        }

        const article = articles.filter((item) => item.id === parseInt(req.params.articleId))[0];
        if (!article) {
            res.status(404).send('Article not found');
        }

        res.send(JSON.stringify(article));
    });
};

export default DetailPageController;
