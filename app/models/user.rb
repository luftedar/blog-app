class User < ApplicationRecord
  has_many :comments, foreign_key: 'user_id'
  has_many :likes, foreign_key: 'user_id'
  has_many :posts, foreign_key: 'user_id'

  def recent_three_posts
    Post.last(3)
  end
end
