Util =
  sum: (arr) ->
    arr.reduce (a, b) -> a + b

  average: (arr) ->
    len = arr.length
    if len > 0
      Util.sum(arr) / len
    else
      0

  round: (num) ->
    Math.floor(num * 100) / 100

module.exports = Util
