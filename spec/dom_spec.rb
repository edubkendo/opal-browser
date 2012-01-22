require File.expand_path('../spec_helper', __FILE__)

describe Browser::DOM do
	it 'parses XML properly' do
		DOM('<a></a>').root.name.should == 'a'
	end

	describe Browser::DOM::Node do
		before do
			@test = DOM(`document.getElementById('test')`)
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

			it 'should find the foo divs' do
				$document.css('div.foo').tap {|a|
					a.length.should == 2

					a.first.name.upcase.should == 'DIV'
					a.last.name.upcase.should == 'DIV'
				}
			end
		end

		if false
		describe '#[]' do
			it 'should find the test div' do
				$document['test'].should == @test
				$document['#test'].should == @test
				$document['div#test'].should == @test
				$document['//[@id="test"]'].should == @test
			end
		end

		describe '#text' do
			it 'should read correctly from the divs' do
				$document['.foo'].text.should == 'omg'
				$document['.bar'].text.should == 'lol'
				$document['.foo.bar'].text.should == 'wat'
			end
		end
		end
	end
end
