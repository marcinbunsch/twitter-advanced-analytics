# @cjsx React.DOM

Util = require('util')

prepareResult = (data, key) ->
  result = {}
  resultRows = []
  hour = 0
  max = 0
  while (hour < 24)
    row = []
    row.hour = hour
    day = 0
    while (day < 7)
      data[day] = data[day] || {}
      record = data[day][hour] || {}
      points = record[key] || []
      number = Util.round(Util.average(points))
      row.push(number)
      max = number if (number > max)
      day++

    resultRows.push(row)
    hour++

  result.max = max
  result.rows = resultRows
  return result

WeekAnalysisTable = React.createClass({
  render: ->
    data = this.props.data.get('week_analysis')
    key = this.props.data.get('week_analysis_context')
    result = prepareResult(data, key)
    rows = [<tr>
      <th></th>
      <th>Monday</th>
      <th>Tuesday</th>
      <th>Wednesday</th>
      <th>Thursday</th>
      <th>Friday</th>
      <th>Saturday</th>
      <th>Sunday</th>
    </tr>]
    result.rows.forEach (row) ->
      cells = [<th className='heading hour'>{row.hour + ':00'}</th>]
      row.forEach (number) ->
        opacity = number / result.max
        opacity = 0.05 if (opacity < 0.05)
        style = { "background-color" : "rgba(116,160,225, " + opacity + ")" }
        cells.push(<td style={style}>{number}</td>)

      rows.push(<tr>{cells}</tr>)

    return <table className='week-analysis'>
      {rows}
    </table>

})

module.exports = WeekAnalysisTable

