class Like < ApplicationRecord
  has_many :likes
  has_many :comments
  belongs_to :author, class_name: 'User', foreign_key: :user_id

  def update_likes_counter
    Post.increment!(:likes_counter)
  end
end
