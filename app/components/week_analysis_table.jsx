/** @jsx React.DOM */

var Util = require('util')

var prepareResult = function(data, key) {
  console.log(data)
  var result = {}
  var resultRows = []
  var hour = 0
  var max = 0
  while (hour < 24) {
    var row = []
    row.hour = hour
    var day = 0
    while (day < 7) {
      data[day] = data[day] || {}
      var record = data[day][hour] || {}
      var points = record[key] || []
      var number = Util.round(Util.average(points))
      row.push(number)
      if (number > max) max = number
      day++
    }
    resultRows.push(row)
    hour++
  }
  result.max = max
  result.rows = resultRows
  return result
}

var WeekAnalysisTable = React.createClass({
  render: function() {
    var data = this.props.data.get('week_analysis')
    var key = this.props.data.get('week_analysis_context')
    var result = prepareResult(data, key)
    var rows = [<tr>
      <th></th>
      <th>Monday</th>
      <th>Tuesday</th>
      <th>Wednesday</th>
      <th>Thursday</th>
      <th>Friday</th>
      <th>Saturday</th>
      <th>Sunday</th>
    </tr>]
    result.rows.forEach(function(row) {
      var cells = [<th className='heading hour'>{row.hour + ':00'}</th>]
      row.forEach(function(number) {
        var opacity = number / result.max
        if (opacity < 0.05) opacity = 0.05
        var style = { "background-color" : "rgba(116,160,225, " + opacity + ")" }
        cells.push(<td style={style}>{number}</td>)
      })
      rows.push(<tr>{cells}</tr>)
    })
    return <table className='week-analysis'>
      {rows}
    </table>
  }
})

module.exports = WeekAnalysisTable
