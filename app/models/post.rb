class Post < ApplicationRecord
  has_many :likes
  has_many :comments
  belongs_to :author, class_name: 'User', foreign_key: :user_id

  def recent_five_comments
    Comment.order('created_at Desc').limit(5)
  end
end
