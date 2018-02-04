/**
 * Separating this from the main server file, allows us to do full es6+ from as low level as possible.
 * */
const fs = require('fs');
const path = require('path');
const config = JSON.parse(fs.readFileSync(path.resolve(__dirname, '../../.babelrc')));

require('babel-core/register')(config);
require.extensions['.scss'] = () => {
    return undefined;
};
require('./server');