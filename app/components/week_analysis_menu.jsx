/** @jsx React.DOM */

var Dispatcher = require('dispatcher')

var WeekAnalysisMenuItem = React.createClass({
  render: function() {
    return <li className={this.props.active ? 'active' : ''}>
      <a className="filter" onClick={this.onClick}>{this.props.name}</a>
    </li>
  },
  onClick: function() {
    Dispatcher.setWeekAnalysisContext(this.props.key)
    return false
  }
})

var WeekAnalysisMenu = React.createClass({
  render: function() {
    var menu = {
      'impressions': 'Impressions',
      'engagements': 'Engagements',
      'retweets': 'Retweets',
      'favorites': 'Favorites'
    }
    var options = []
    var key = null
    var context = this.props.data.get('week_analysis_context')
    for (key in menu) {
      var name = menu[key]
      var active = context == key
      var option = <WeekAnalysisMenuItem active={active} name={name} key={key} />
      options.push(option)
    }
    return <div className="navigation">
      <ul className="nav nav-pills">
        {options}
      </ul>
    </div>
  }
})

module.exports = WeekAnalysisMenu

