Hijacker =

  addAdvancedLink: ->
    $('#SharedNavBarContainer ul:first').append('<li class="SharedNavBar-navItem advanced"><a id="advancedTrigger" href="?advanced=true">Advanced</a></li>')

  takeOverPage: ->
    $('#SharedNavBarContainer ul li').removeClass('is-active')
    $('#SharedNavBarContainer li.advanced').addClass('is-active')
    $('.main-page-header .container h1').text('Advanced')
    $('.full-page').html('<div id="mount"></div>')
    $('.tweet-activity-export').html('<div id="status"></div>')

  mount: ->
    $('#mount').get(0)

module.exports = Hijacker
