require 'browser'

$document['a'].on :click do |e|
	alert text
end

$document['a'].on :hover do |e|
	`window.event = e`
end
