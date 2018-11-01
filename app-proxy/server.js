var express = require('express')
var app = express()
var path = require('path')
var request = require('request')

const PORT = process.env.PORT || 8080

// prepare index.html and replace environment variables in it
// we use the 'original' that should be provided in the build step

app.use('/proxy', function (req, res) {
  var url = req.url.substr(1)
  console.log('REQUEST IS ', url)
  var newRequest = null
  res.append('X-UFP-PROXY', '1');
  switch (req.method) {
    case 'POST':
      newRequest = request.post({
        uri: url,
        json: req.body,
        headers: req.headers
      })
      break
    case 'PUT':
      newRequest = request.post({
        uri: url,
        json: req.body,
        headers: req.headers
      })
      break
    case 'DELETE':
      newRequest = request.delete({
        uri: url,
        json: req.body,
        headers: req.headers
      })
      break
    case 'HEAD':
      newRequest = request.head({
        uri: url,
        json: req.body,
        headers: req.headers
      })
      break
    case 'OPTIONS':
      newRequest = request.options({
        uri: url,
        json: req.body,
        headers: req.headers
      })
      break
    case 'PATCH':
      newRequest = request.path({
        uri: url,
        json: req.body,
        headers: req.headers
      })
      break
    default:
      newRequest = request({
        uri: url,
        headers: req.headers
      })
  }
  console.log('REQUEST FORWARDING ')

  req.pipe(newRequest).on('error', function (err) {
    console.log('Error Occurred', err)
    res.json(err)
  }).pipe(res)
  console.log('REQUEST END')
})

const distPath=path.resolve(process.cwd(),'..')
console.log('dist path is __dirname',__dirname)
console.log('dist path is ',distPath)
app.use('/', express.static(distPath))

app.listen(PORT, function () {
  console.log(`Example app listening on port ${PORT}`)
})
