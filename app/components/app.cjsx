# @cjsx React.DOM

Database = require('components/database')
Dispatcher = require('dispatcher')
WeekAnalysis = require('components/week_analysis')

PillsMenu = React.createClass
  render: ->
    context = this.props.data.get('context')
    return <div className="navigation">
      <ul className="nav nav-pills">
        <li className={if context == 'behavior' then 'active' else ''}>
          <a className="filter" onClick={Dispatcher.showBehaviorPage}>Week Analysis</a>
        </li>
        <li className={if context == 'database' then 'active' else ''}>
          <a className="filter" onClick={Dispatcher.showDatabasePage}>Database</a>
        </li>
      </ul>
    </div>


App = React.createClass
  render: ->
    if this.props.data.get('boot')
      return <div className="booting">
        Loading database
      </div>
    else
      contents = []
      if this.contextIs('database')
        contents.push(<Database data={this.props.data} />)
      if this.contextIs('behavior')
        contents.push(<WeekAnalysis data={this.props.data} />)
      console.log(contents)
      return <div>
        <PillsMenu data={this.props.data}/>
        {contents}
      </div>

  contextIs: (name) ->
    return this.getContext() == name

  getContext: ->
    return this.props.data.get('context')

module.exports = App

