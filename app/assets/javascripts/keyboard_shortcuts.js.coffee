shortcuts = {}

$ ->
  $("a[data-shortcut]").each (index, link) ->
    link = $(link)
    shortcuts[link.data("shortcut").charCodeAt(0)] = link
    link.html(link.html().replace(new RegExp("(" + link.data("shortcut") + ")", "i"), "<span class='shortcut'>$1</span>"))

  $(document).keypress (event) ->
    if shortcuts[event.which]
      window.location = shortcuts[event.which].attr("href")
