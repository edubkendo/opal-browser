#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

require 'opal/browser/dom/node_set'

require 'opal/browser/dom/node'
require 'opal/browser/dom/attribute'
require 'opal/browser/dom/character_data'
require 'opal/browser/dom/text'
require 'opal/browser/dom/cdata'
require 'opal/browser/dom/comment'
require 'opal/browser/dom/element'
require 'opal/browser/dom/document'

require 'opal/browser/dom/event'

module Kernel
	def DOM (what)
		if String === what
			%x{
				var doc;

				if (window.DOMParser) {
					doc = new DOMParser().parseFromString(what, 'text/xml');
				}
				else {
					doc       = new ActiveXObject('Microsoft.XMLDOM');
					doc.async = 'false';
					doc.loadXML(what);
				}
			}

			DOM(`doc`)
		else
			Browser::DOM::Node.from_native(Native.normalize(what))
		end
	end
end
