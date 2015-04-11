$.fn.chained_node_select = ->
  @.each ->
    hidden_field  = $(@)
    fid           = hidden_field.val()
    level_max     = 0
    prefix        = hidden_field.attr('id') + '_level_'

    loadLevel = (pid, before_element) ->
      level = level_max
      level_max += 1

      $.ajax
        url: '/nodes/options',
        dataType: 'json',
        data:
          pid: pid,
          fid: fid,
        success: (data) ->
          return if data.length < 1

          select = $('<select id="' + (prefix + level) + '" class="form-control md mb">').css
            display: 'block',
            marginLeft: level * 20
          .insertAfter(before_element)

          $('<option>').appendTo(select)
          $('<option>', item).appendTo(select) for item in data

          if fid && select.val()
            loadLevel(select.val(), select)
            fid = null if fid == select.val()

          select.on 'change', ->
            $('#'+prefix+(level_max -= 1)).remove() while level_max > level + 1
            loadLevel(select.val(), select) if select.val()
            hidden_field.val(select.val() || before_element.val())

    loadLevel(null, hidden_field)

