require File.expand_path('../spec_helper', __FILE__)

describe Window do
	describe '#document' do
		it 'should return `document`' do
			Window.document.should == `document`
		end
	end
end