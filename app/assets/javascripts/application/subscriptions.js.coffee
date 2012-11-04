$(document).ready ->

  $('#subscribe-btn').click ->
    $('div#new-subscription-container').show()

  $("div#new-subscription-container input[value='Cancel']").click ->
    $('div#new-subscription-container').hide()

  $('#new_subscription').on('ajax:success', (event, object)->
    $(this).parent().hide()

    li = $('<li/>').addClass('subscription-title')
    link = $("<a/>").attr('href', '/subscriptions/' + object.id).attr('data-remote', 'true').attr('data-id', object.id).text(object.title)

    li.append(link)

    $('li#subscriptions ul.small').append(li)
  )

  $('a.subscription-link').on('ajax:success', (event, data) ->
    $('ul#feed-items').attr('data-id', $(this).attr('data-id'))
    $('ul#feed-items').html(data)
  )
