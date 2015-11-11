@Deployment =
  showService: (url) ->
    $.ajax
      url: url
      method: "GET"
      async: false
      success: (resp) ->
        $("#deploymentContent").innerHtml(resp);
      error: (resp) ->

jQuery ->
  $("#deployment_link a").each ->
    Qdeploy.initModalLink(this)