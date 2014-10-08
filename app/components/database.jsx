/** @jsx React.DOM */
var Dispatcher = require('dispatcher')
var Blacklist = require('blacklist')

var Tweet = React.createClass({

  render: function() {
    var tweet = this.props.tweet
    var doc = this.props.tweet.doc
    var text = doc['Tweet text']
    var impressions = doc['impressions']
    var engagements = doc['engagements']
    var time = doc['time']
    var retweets = doc['retweets']
    var favorites = doc['favorites']
    var ignored = Blacklist.isIgnored(tweet.id)
    var formattedTime = moment(time).format('HH:mm, DD/MM/YYYY')
    return <tr>
      <td className="time">
        {formattedTime}
      </td>
      <td className="text">
        <div>
        {text}
        </div>
      </td>
      <td className="impressions">
        {impressions}
      </td>
      <td className="engagements">
        {engagements}
      </td>
      <td className="retweets">
        {retweets}
      </td>
      <td className="favorites">
        {favorites}
      </td>
      <td className="ignored">
        <input type="checkbox" checked={ignored} onChange={this.toggleIgnore} />
      </td>
    </tr>
  },
  toggleIgnore: function() {
    var tweet = this.props.tweet
    Dispatcher.toggleIgnore(tweet)
  }
})

var Database = React.createClass({
  render: function() {
    var tweets = this.props.data.get('tweets') || []
    var rows = []
    tweets.forEach(function(tweet) {
      rows.push(<Tweet tweet={tweet} />)
    })
    return <table className="database">
      <tr>
        <th>Time</th>
        <th>Tweet</th>
        <th>Impressions</th>
        <th>Engagements</th>
        <th>Retweets</th>
        <th>Favorites</th>
        <th>Ignored</th>
      </tr>
      {rows}
    </table>
  }
})

module.exports = Database
