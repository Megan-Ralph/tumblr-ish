require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:body) }
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:end_date) }
  end

  describe 'database constraints' do
    it 'raises an error if title is not present' do
      event = Event.new(body: 'example body')
      expect { event.save(validate: false) }.to raise_error(ActiveRecord::NotNullViolation)
    end

    it 'raises an error if body is not present' do
      event = Event.new(title: 'example title')
      expect { event.save(validate: false) }.to raise_error(ActiveRecord::NotNullViolation)
    end

    it 'raises an error if start_date is not present' do
      event = Event.new(title: 'example title', body: 'example body', end_date: DateTime.now)
      expect { event.save(validate: false) }.to raise_error(ActiveRecord::NotNullViolation)
    end

    it 'raises an error if end_date is not present' do
      event = Event.new(title: 'example title', body: 'example body', start_date: DateTime.now)
      expect { event.save(validate: false) }.to raise_error(ActiveRecord::NotNullViolation)
    end
  end
end
