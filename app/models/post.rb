class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :likes

  after_save :update_posts_counter

  def update_posts_counter
    user.increment!(:posts_counter)
  end
  def recent_comments
    comments.limit(5).order(created_at: :desc)
  end
end
