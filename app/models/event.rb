class Event < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :user_id, presence: true
end
