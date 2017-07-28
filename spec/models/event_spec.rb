require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:test_event) { Event.create(title: 'title', date: '2017-07-27', time: '2000-01-01 23:51:12', location: 'sea', summary: 'that') }
  
  context 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:date) }
    it { is_expected.to validate_presence_of(:time) }
    it { is_expected.to validate_presence_of(:location) }
    it { is_expected.to validate_presence_of(:summary) }
  end

  it '#format_time' do
    expect(test_event.format_time).to eq '11:51 PM'
  end

  it '#formate_date' do
    expect(test_event.format_date).to eq '07/27/2017'
  end

  it '#month' do
    expect(test_event.month).to eq '07'
  end

  context 'associations' do
    it { is_expected.to belong_to(:owner) }
  end
end