jQuery ->
  #$('tree').collapse()
  console.log('here2')
  #Ladda.bind( 'input[type=submit]' );
  $('.hideable').click ->
    $(this).parent().find('ul').toggle()
  $('.token.editable').editable
    ajaxOptions:
      type: "patch"
      dataType: "json"
    params: (params)->
      params['token'] = {value: params.value}
      return params
    display: (value, sourceData)->
      console.log('here3')
      #$(this).html("<span class='text-error'><i class='icon-key'></i>" + $(this).data('key') + " - " + value + "</span>")
      $(this).html("<span class='text-error'>" + value + "</span>")
      #$("#text_box_label901").hide()
