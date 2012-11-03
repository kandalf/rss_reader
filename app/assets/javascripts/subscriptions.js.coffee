$(document).ready ->

  $('#subscribe-btn').click ->
    $('div#new-subscription-container').show()

  $("div#new-subscription-container input[value='Cancel']").click ->
    $('div#new-subscription-container').hide()

