var express = require('express')
var app = express()
var path = require('path')
var request = require('request')

var Transform = require('stream').Transform
var parser = new Transform()
parser._transform = function (data, encoding, done) {
  console.log('Parser called1',  encoding)
  console.log('Parser called2',  done)
  console.log('Parser called3', data)
  console.log('Parser called4', data.toString())

  this.push(data)
  done()
}
app.use('/proxy', function (req, res) {
  console.log('REQUEST IS ', req.url)
  var url = req.url.substr(1)
  var r = null
  switch (req.method) {
    case 'POST':
      r = request.post({
        uri: url,
        json: req.body,
        headers: req.headers
      })
      break
    case 'PUT':
      r = request.post({
        uri: url,
        json: req.body,
        headers: req.headers
      })
      break
    case 'DELETE':
      r = request.delete({
        uri: url,
        json: req.body,
        headers: req.headers
      })
      break
    case 'HEAD':
      r = request.head({
        uri: url,
        json: req.body,
        headers: req.headers
      })
      break
    case 'OPTIONS':
      r = request.options({
        uri: url,
        json: req.body,
        headers: req.headers
      })
      break
    case 'PATCH':
      r = request.path({
        uri: url,
        json: req.body,
        headers: req.headers
      })
      break
    default:
      r = request({
        uri: url,
        headers: req.headers
      })
  }
  console.log('REQUEST FORWARDING ')

  req.pipe(r).pipe(res)
  console.log('REQUEST END')
})

app.use('/', express.static(path.resolve(__dirname, '..', 'dist')))

app.listen(3000, function () {
  console.log('Example app listening on port 3000!')
})
