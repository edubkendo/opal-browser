require File.expand_path('../spec_helper', __FILE__)

describe Browser::Document do
	before do
		@test = `document.getElementById('test')`
	end

	describe '#xpath' do
		it 'should find the test div' do
			$document.xpath('//div[@id="test"]').tap {|a|
				a.length.should == 1
				
				`#{a.first.to_native} == #@test`.should be_true
			}
		end
	end

	describe '#css' do
		it 'should find the test div' do
			$document.css('div#test').tap {|a|
				a.length.should == 1

				`#{a.first.to_native} == #@test`.should be_true
			}
		end
	end

	describe '#[]' do
		it 'should find the test div' do
			`#{$document['test']} == #@test`.should be_true
			`#{$document['#test']} == #@test`.should be_true
			`#{$document['div#test']} == #@test`.should be_true
			`#{$document['//[@id="test"]']} == #@test`.should be_true
		end
	end
end
