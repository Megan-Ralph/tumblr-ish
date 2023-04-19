class Comment < ApplicationRecord
  belong_to :user
  belongs_to :commentable, polymorphic: true
end
  