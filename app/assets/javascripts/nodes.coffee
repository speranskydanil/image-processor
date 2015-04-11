$(document).ready ->
  # expander

  $('.metadata .expander').click (e) ->
    e.preventDefault()

    $(@).find('span').toggleClass 'glyphicon-chevron-right glyphicon-chevron-down'

    $('.metadata .wrapper').slideToggle ->
      $.cookie 'expander', if $(@).is(':visible') then 'show' else 'hide'

  # grids

  $('.nodes-sorting-grid > ul').sortable(handle: 'img')

