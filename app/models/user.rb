class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :articles
  has_many :events
  has_many :comments
  has_many :likes

  def activity_feed
    query = <<-SQL
      (SELECT id, title, NULL as body, NULL as commentable_type, NULL as commentable_id, created_at, 'Article' as type FROM articles WHERE user_id = :user_id)
      UNION ALL
      (SELECT id, title, NULL as body, NULL as commentable_type, NULL as commentable_id, created_at, 'Event' as type FROM events WHERE user_id = :user_id)
      UNION ALL
      (SELECT id, NULL as title, body, commentable_type, commentable_id, created_at, 'Comment' as type FROM comments WHERE user_id = :user_id AND (commentable_type = 'Article' OR commentable_type = 'Event'))
      ORDER BY created_at DESC
      LIMIT 10
    SQL
  
    raw_activities = ActiveRecord::Base.connection.select_all(ActiveRecord::Base.send(:sanitize_sql_array, [query, user_id: self.id]))

    if raw_activities.present?
      activities = raw_activities.map do |activity|
        {
          id: activity['id'].to_i,
          title: activity['title'],
          body: activity['body'],
          commentable_type: activity['commentable_type'],
          commentable_id: activity['commentable_id'].to_i,
          created_at: activity['created_at'].to_time,
          type: activity['type']
        }
      end
    else
      activities = []
    end
  
    activities
  end
end
