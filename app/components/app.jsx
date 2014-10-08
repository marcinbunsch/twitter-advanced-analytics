/** @jsx React.DOM */

var Database = require('components/database')
var Dispatcher = require('dispatcher')
var WeekAnalysis = require('components/week_analysis')

var PillsMenu = React.createClass({
  render: function() {
    var context = this.props.data.get('context')
    return <div className="navigation">
      <ul className="nav nav-pills">
        <li className={context == 'behavior' ? 'active' : ''}>
          <a className="filter" onClick={Dispatcher.showBehaviorPage}>Week Analysis</a>
        </li>
        <li className={context == 'database' ? 'active' : ''}>
          <a className="filter" onClick={Dispatcher.showDatabasePage}>Database</a>
        </li>
      </ul>
    </div>
  }
})


var App = React.createClass({
  render: function() {
    if (this.props.data.get('boot')) {
      return <div className="booting">
        Loading database
      </div>
    } else {
      var contents = []
      if (this.contextIs('database'))
        contents.push(<Database data={this.props.data} />)
      if (this.contextIs('behavior'))
        contents.push(<WeekAnalysis data={this.props.data} />)
      return <div>
        <PillsMenu data={this.props.data}/>
        {contents}
      </div>
    }
  },
  contextIs: function(name) {
    return this.getContext() == name
  },
  getContext: function() {
    return this.props.data.get('context')
  }
})

module.exports = App

