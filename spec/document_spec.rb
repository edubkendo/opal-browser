require File.expand_path('../spec_helper', __FILE__)

describe Browser::Document do
	before do
		@test = Element(`document.getElementById('test')`)
	end

	describe '#xpath' do
		it 'should find the test div' do
			$document.xpath('//div[@id="test"]').tap {|a|
				a.length.should == 1
				
				a.first.should == @test
			}
		end
	end

	describe '#css' do
		it 'should find the test div' do
			$document.css('div#test').tap {|a|
				a.length.should == 1

				a.first.should == @test
			}
		end
	end

	describe '#[]' do
		it 'should find the test div' do
			$document['test'].should == @test
			$document['#test'].should == @test
			$document['div#test'].should == @test
			$document['//[@id="test"]'].should == @test
		end
	end
end
