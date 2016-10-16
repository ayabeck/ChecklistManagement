$ ->
  # jquery-ui-sortable
  # form_item をドラッグ＆ドロップで並べ替え
  $('.item-sortable').sortable
    cursor: 'move'
    opacity: 0.7
    axis: 'y'
    placeholder: 'sortable-placeholder'
    start: (e, ui) ->
      ui.item.css 'background': '#EFEFEF'
    stop: (event, ui) ->
      ui.item.css 'background': '#FFF'
      ui.item.effect 'highlight'
      url = $(this).data().updateUrl
      result = $(this).sortable('serialize', {key: 'ids[]'})
      $.ajax
       type: 'PUT'
       url: url
       data: result
