$(document).ready ->
  # bootstrap

  $('a[rel=popover]').popover()
  $('a[rel=tooltip]').tooltip()

  $('.nav-tabs a').click (e) ->
    e.preventDefault()
    $(@).tab 'show'

  # sortable

  $('.sortable').sortable
    handle: '.handle'

    helper: (e, el) ->
      return el unless el.is('tr')

      helper = el.clone()

      helper.children().each (index) ->
        $(@).width el.children().eq(index).width()

      return helper

  # fancybox

  $('.fancybox').fancybox
    helpers:
      thumbs:
        width: 82,
        height: 123

  # scroll-up

  $('.scroll-up').disableSelection()

  $('.scroll-up span').click ->
    $('html, body').animate scrollTop: 0

  $(window).scroll ->
    if $(window).scrollTop() > 320
      $('.scroll-up').fadeIn()
    else
      $('.scroll-up').fadeOut()

  # compass

  $('.compass').disableSelection()

  # pagination

  $('.pagination .per_page select').change ->
    location = window.location.toString()
    location = $.url(location).unset('page').set('per_page', $(@).val()).toString()
    window.location.replace location

  # recaptcha

  $('#recaptcha_response_field').css 'width': '288px', 'border-color': '#ccc'

