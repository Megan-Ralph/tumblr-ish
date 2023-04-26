require 'rails_helper'

RSpec.describe Article, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:body) }
  end

  describe 'database constraints' do
    it 'raises an error if title is not present' do
      article = Article.new(body: 'example body')
      expect { article.save(validate: false) }.to raise_error(ActiveRecord::NotNullViolation)
    end

    it 'raises an error if body is not present' do
      article = Article.new(title: 'example title')
      expect { article.save(validate: false) }.to raise_error(ActiveRecord::NotNullViolation)
    end
  end
end
