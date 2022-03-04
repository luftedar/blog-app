class Post < ApplicationRecord
  validates :comments_counter, :likes_counter, numericality: { greater_than_or_equal_to: 0 }
  validates :title, presence: true, length: { maximum: 250 }
  belongs_to :user
  has_many :comments
  has_many :likes

  def update_posts_counter
    user.increment!(:posts_counter)
  end

  def recent_comments
    comments.limit(5).order(created_at: :desc)
  end
end
