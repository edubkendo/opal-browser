require File.expand_path('../spec_helper', __FILE__)

describe `Document` do
	describe '#xpath' do
		it 'should find the test div' do
			$window.document.xpath('//div[@id="test"]').tap {|a|
				a.length.should == 1
				
				`(#{a.first.to_native} == document.getElementById('test'))`.should be_true
			}
		end
	end

	describe '#css' do
		it 'should find the test div' do
			$window.document.css('div#test').tap {|a|
				a.length.should == 1

				`(#{a.first.to_native} == document.getElementById('test'))`.should be_true
			}
		end
	end
end
