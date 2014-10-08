# @cjsx React.DOM

Dispatcher = require('dispatcher')

WeekAnalysisMenuItem = React.createClass
  render: ->
    return <li className={this.props.active ? 'active' : ''}>
      <a className="filter" onClick={this.onClick}>{this.props.name}</a>
    </li>

  onClick: ->
    Dispatcher.setWeekAnalysisContext(this.props.key)
    return false

WeekAnalysisMenu = React.createClass({
  render: ->
    menu = {
      'impressions': 'Impressions',
      'engagements': 'Engagements',
      'retweets': 'Retweets',
      'favorites': 'Favorites'
    }
    options = []
    key = null
    context = this.props.data.get('week_analysis_context')
    for key in menu
      name = menu[key]
      active = context == key
      option = <WeekAnalysisMenuItem active={active} name={name} key={key} />
      options.push(option)

    return <div className="navigation">
      <ul className="nav nav-pills">
        {options}
      </ul>
    </div>
})

module.exports = WeekAnalysisMenu

