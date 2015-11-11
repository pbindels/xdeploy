@Qdeploy =
  initModalLink: (link) ->
    $(link).bind "click", (e)->
      e.preventDefault()
      $('<div/>').dialog2
        id: $(link).data("modal-id")
        title: $(link).data("title")
        content: $(link).data("content-url")

jQuery ->
  $("[rel=modal-link]").each ->
    Qdeploy.initModalLink(this)

  $("[data-toggle='tooltip']").tooltip()
