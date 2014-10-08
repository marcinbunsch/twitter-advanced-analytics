/** @jsx React.DOM */
var WeekAnalysisMenu = require('components/week_analysis_menu')
var WeekAnalysisTable = require('components/week_analysis_table')

var WeekAnalysis = React.createClass({
  render: function() {
    return <div>
      <WeekAnalysisMenu data={this.props.data} />
      <WeekAnalysisTable data={this.props.data} />
    </div>
  }

})

module.exports = WeekAnalysis

