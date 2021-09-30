const fetch = require('node-fetch')

module.exports = function (url, args) {
  return fetch(`${url}?FinRestApp`, args)
}
