class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :likes, as: :likeable, dependent: :destroy

  validates :body, presence: true

  def article?
    commentable_type == "Article"
  end
  
  def event?
    commentable_type == "Event"
  end

  def activity_title
    commentable_type + "-" + commentable.title
  end
end
