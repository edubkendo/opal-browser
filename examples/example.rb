require 'browser'

$document['a'].on :click do |e|
	alert self.text
end

$document['a'].on :hover do |e|
	`window.event = e`
end
