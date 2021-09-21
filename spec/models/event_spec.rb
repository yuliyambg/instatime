
describe Event do

  it 'should have user ' do
    event = create(:event)
    expect(event.valid?).to eq(true)
  end

end