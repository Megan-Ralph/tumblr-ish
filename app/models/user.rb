class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :articles
  has_many :events
  has_many :comments

  def activity_feed
    articles = self.articles.select("id, title, created_at, 'Article' as type")
    events = self.events.select("id, title, created_at, 'Event' as type")
    comments = Comment.where(commentable: [self.articles, self.events]).select("id, body, commentable_type, commentable_id, created_at, 'Comment' as type")

    activities = (articles + events + comments).sort_by(&:created_at).reverse.take(10)
    return activities
  end
end
