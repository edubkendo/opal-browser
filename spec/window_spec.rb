require File.expand_path('../spec_helper', __FILE__)

describe Window do
	describe '#document' do
		it 'should return `document`' do
			`(#{Window.document.to_native} == document)`.should be_true
		end
	end
end
