var express = require('express')
var app = express()
var path = require('path')
var request = require('request')


app.use('/proxy', function (req, res) {
  console.log('REQUEST IS ', req.url)
  var url = req.url.substr(1)
  var r = null
  switch(req.method){
    case 'POST':
      r = request.post({
        uri: url,
        json: req.body
      })
      break
    case 'PUT':
      r = request.post({
        uri: url,
        json: req.body
      })
      break
    default:
      r = request(url)
  }
    console.log('REQUEST FORWARDING ', r)


  req.pipe(r).pipe(res)
  console.log('REQUEST END')

})

app.use('/', express.static(path.resolve(__dirname,'..','dist')));

app.listen(3000, function () {
  console.log('Example app listening on port 3000!')
})
