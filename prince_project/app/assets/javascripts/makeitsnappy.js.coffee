Makeitsnappy = {}

Makeitsnappy.autoSelectSearch = ->
	window.onload = ->
		keyword = document.getElementById 'keyword'
		keyword.onclick = ->
			@select()

Makeitsnappy.autoSelectSearch()