require 'computer'

describe Computer do
	let(:computer) { Computer.new }

	it 'has Computer as name' do
		expect(computer.name).to eq "Computer"
	end

	it 'can make a random pick' do
		allow(computer).to receive(:random_pick).and_return "Rock"
		expect(computer.random_pick).to eq "Rock"
	end

end