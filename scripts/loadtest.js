// @docs https://npmjs.org/package/loadtest

var loadtest = require('loadtest');
var options = {
    url: 'http://localhost:3001/getTodaysPledges',
    method: "GET",
    concurrency: 10,
    maxRequests: 1000,
    headers: ["Content-Type: application/json"]
};
loadtest.loadTest(options, function(error, result) {
    if (error) {
        return console.error('Got an error: %s', error, result);
    }
    console.info('Tests run successfully', result);
});
