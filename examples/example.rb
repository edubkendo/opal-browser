require 'browser'

$document['a'].on :click do |e|
	alert e
end

$document['a'].on :hover do |element, event|
	`window.event = event`
end
