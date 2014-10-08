Blacklist = require('blacklist')

class WeekAnalyzer

  constructor: (tweets) ->
    @tweets = tweets

  analyze: ->
    @result = {}
    @result.max =
      impressions: 0
      engagements: 0
      favorites: 0
      retweets: 0
    @tweets.forEach(this.analyzeTweet)
    return @result

  analyzeTweet: (tweet) =>
    return if Blacklist.isIgnored(tweet.id)
    time = new Date(tweet.doc.time)

    day = time.getDay()
    # fixup the fact that sunday is 0
    day = day - 1
    day = 6 if day == -1

    hour = time.getHours()

    @result[day] || = {}
    @result[day][hour] ||= {
      impressions: [],
      engagements: [],
      favorites: [],
      retweets: [],
    }
    ['impressions', 'engagements', 'favorites', 'retweets'].forEach (key) =>
      number = parseInt(tweet.doc[key])
      @result[day][hour][key].push number
      @result.max[key] = number if number > @result.max[key]

module.exports = WeekAnalyzer
