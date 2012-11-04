(->
  subscription_id = $('ul#feed-items').attr('data-id')

  updateArticles = (articles, textStatus, xhr) ->
    showNewArticle(article) for article in articles

  showNewArticle = (article) ->
    link = $('<a/>').attr('target', '_blank').attr('href', article.urls.first)
    link.text(article.title)
    
    content = $('<div/>').addClass('article-content').html(article.content)

    item = $("<li/>")

    item.append($('<h4/>').append(link)).append(content)

    $('ul#feed-items').prepend(item)


  $.getJSON('/subscriptions/' + subscription_id + '/refresh', {}, updateArticles)
)()
