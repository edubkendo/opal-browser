require File.expand_path('../spec_helper', __FILE__)

describe `Document` do
	describe '#xpath' do
		it 'should find the test div' do
			Window.document.xpath('//div[@id="test"]').tap {|a|
				a.length.should == 1 && a.first.should == `document.getElementById('test')`
			}
		end
	end

	describe '#css' do
		it 'should find the test div' do
			Window.document.css('div#test').tap {|a|
				a.length.should == 1 && a.first.should == `document.getElementById('test')`
			}
		end
	end
end
