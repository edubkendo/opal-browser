require 'browser'

$document.search('a').on(:hover) {|e|
	log 'Thou hovered a link, how dare thee?'
}.on(:click) {|e|
	alert "Yo dawg, you clicked the link with the following text: #{text}"
}
