$(document).ready ->

  $('#subscribe-btn').click ->
    $('div#new-subscription-container').show()

  $("div#new-subscription-container input[value='Cancel']").click ->
    $('div#new-subscription-container').hide()

  $('#new_subscription').on('ajax:success', (event, object)->
    $(this).parent().hide()

    li = $('<li/>').addClass('subscription-title').attr('data-subscription-id', object.id)
    link = $("<a/>").attr('href', '/subscriptions/' + object.id).attr('data-remote', 'true').text(object.title)
    li.append(link)
    $('li#subscriptions ul.small').append(li)
  )
