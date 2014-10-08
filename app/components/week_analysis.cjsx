# @cjsx React.DOM

WeekAnalysisMenu = require('components/week_analysis_menu')
WeekAnalysisTable = require('components/week_analysis_table')

WeekAnalysis = React.createClass({

  render: ->
    return <div>
      <WeekAnalysisMenu data={this.props.data} />
      <WeekAnalysisTable data={this.props.data} />
    </div>

})

module.exports = WeekAnalysis


