$(document).ready ->
  # expander

  $('.metadata .expander').click (e) ->
    e.preventDefault()

    $(@).find('span').toggleClass 'glyphicon-chevron-right glyphicon-chevron-down'

    $('.metadata .wrapper').slideToggle ->
      $.cookie 'expander', if $(@).is(':visible') then 'show' else 'hide'

  # grids

  $('.nodes-sorting-grid > ul').sortable(handle: 'img')

  # zip

  $('.nodes-generate-zip').click (e) ->
    e.preventDefault()

    self = $(this)

    return if self.hasClass 'disabled'

    self.addClass 'disabled'
    self.text self.data('generating-zip')

    action = "#{document.location.origin}#{document.location.pathname}/generate_zip"

    $.post action, (path) ->
      interval = setInterval ->
        $.ajax
          url: path,
          type: 'HEAD',

          success: ->
            clearInterval(interval)

            setTimeout ->
              self.text self.data('download-zip')
              self.removeClass('disabled')
              self.attr 'href', path
              self.unbind()
            , 4000
      , 2000

