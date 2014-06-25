#= require_tree .

if window.navigator.standalone
  window.onload = ->
    document.body.className = 'webview'
