$(document).ready ->
  # bootstrap

  $('*[rel*=popover]').popover()

  $('body').tooltip
    selector: '*[rel*=tooltip]'
    delay: 200

  $('.nav-tabs a').click (e) ->
    e.preventDefault()
    $(@).tab 'show'

  # fancybox

  $('.fancybox').fancybox
    helpers:
      thumbs:
        width: 82,
        height: 123

  # sortable

  $('.sortable').sortable
    handle: '.handle'

    helper: (e, el) ->
      return el unless el.is('tr')

      helper = el.clone()

      helper.children().each (index) ->
        $(@).width el.children().eq(index).width()

      return helper

  # chained node select

  $('.chained-node-select').chained_node_select()

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

  $('.pagination-wr .per-page select').change ->
    location = window.location.toString()
    location = $.url(location).unset('page').set('per_page', $(@).val()).toString()
    window.location.replace location

  # recaptcha

  $('#recaptcha_response_field')
    .attr 'style', ''
    .css 'width', '288px'

  setTimeout ->
    $('#recaptcha_response_field')
      .attr 'style', ''
      .css 'width', '288px'
  , 200

  # spoiler

  $('.spoiler > a').click (e) ->
    e.preventDefault()
    $(@).parent().toggleClass('active')
    $(@).find('span').toggleClass('glyphicon-chevron-right glyphicon-chevron-down')

