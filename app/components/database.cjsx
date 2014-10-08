# @cjsx React.DOM

Dispatcher = require('dispatcher')
Blacklist = require('blacklist')

Tweet = React.createClass({

  render: ->
    tweet = this.props.tweet
    doc = this.props.tweet.doc
    text = doc['Tweet text']
    impressions = doc['impressions']
    engagements = doc['engagements']
    time = doc['time']
    retweets = doc['retweets']
    favorites = doc['favorites']
    ignored = Blacklist.isIgnored(tweet.id)
    formattedTime = moment(time).format('HH:mm, DD/MM/YYYY')
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

  toggleIgnore: ->
    tweet = this.props.tweet
    Dispatcher.toggleIgnore(tweet)

})

Database = React.createClass({

  render: ->
    tweets = this.props.data.get('tweets') || []
    rows = []
    tweets.forEach (tweet) ->
      rows.push(<Tweet tweet={tweet} />)
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

})

module.exports = Database

