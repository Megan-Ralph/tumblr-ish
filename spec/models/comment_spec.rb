require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:body) }
  end

  describe 'database constraints' do
    it 'raises an error if body is not present' do
      comment = Comment.new(body: 'example body')
      expect { comment.save(validate: false) }.to raise_error(ActiveRecord::NotNullViolation)
    end
  end
end
