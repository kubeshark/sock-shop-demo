import fetch, { FormData } from 'node-fetch'

const ACCESS_TOKEN = "c798b14b83d519ffc531ef816cfce81e7d53367dbd5c4d3171a06ad888fabdaf"

function doRequests() {
    var formData = new FormData()
    formData.set('email', 'john.doe@example.com')
    formData.set('name', 'John')
    formData.set('gender', 'male')
    formData.set('status', 'active')
    var headers = {
        'content-type': 'multipart/form-data',
        'authorization': `Bearer ${ACCESS_TOKEN}`,
        'cache-control': 'no-cache',
        'x-powered-by': 'nodejs-fetch'
    }

    var response = await fetch('https://gorest.co.in/public/v2/users', { method: 'POST', headers: headers, body: formData })
    var data = await response.json()
    console.log(data)


    var headers = {
        'cache-control': 'no-cache',
        'x-powered-by': 'nodejs-fetch'
    }

    var response = await fetch('https://gorest.co.in/public/v2/users', { method: 'GET', headers: headers })
    var data = await response.json()
    console.log(data)


    var headers = {
        'cache-control': 'no-cache',
        'x-powered-by': 'nodejs-fetch'
    }

    var response = await fetch('https://gorest.co.in/public/v2/posts', { method: 'GET', headers: headers })
    var data = await response.json()
    console.log(data)

    setTimeout(doRequests, 3000);
}

doRequests();
