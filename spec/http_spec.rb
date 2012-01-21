require File.expand_path('../spec_helper', __FILE__)

describe Browser::HTTP do
	describe File do
		describe '.read' do
			it 'works properly' do
				File.read('lol.txt').should == "lolwut\n"
			end
		end
	end

	it 'fetches a file correctly' do
		Browser::HTTP.get('lol.txt') { synchronous! }.text.should == "lolwut\n"
	end
end
