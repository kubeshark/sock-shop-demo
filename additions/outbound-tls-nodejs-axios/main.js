import axios from 'axios';

const ACCESS_TOKEN = "c798b14b83d519ffc531ef816cfce81e7d53367dbd5c4d3171a06ad888fabdaf"

function doRequests() {
    axios.post('https://gorest.co.in/public/v2/users', {
        email: 'john.doe@example.com',
        name: 'John',
        gender: 'male',
        status: 'active'
    }, {
        headers: {
            'content-type': 'multipart/form-data',
            'authorization': `Bearer ${ACCESS_TOKEN}`,
            'cache-control': 'no-cache',
            'x-powered-by': 'nodejs-axios'
        }
    })
    .then(function (response) {
        console.log(response);
    })
    .catch(function (error) {
        console.log(error);
    });


    axios.get('https://gorest.co.in/public/v2/users', {}, {
        headers: {
            'cache-control': 'no-cache',
            'x-powered-by': 'nodejs-axios'
        }
    })
    .then(function (response) {
        console.log(response);
    })
    .catch(function (error) {
        console.log(error);
    });


    axios.get('https://gorest.co.in/public/v2/posts', {}, {
        headers: {
            'cache-control': 'no-cache',
            'x-powered-by': 'nodejs-axios'
        }
    })
    .then(function (response) {
        console.log(response);
    })
    .catch(function (error) {
        console.log(error);
    });

    setTimeout(doRequests, 3000);
}

doRequests();
