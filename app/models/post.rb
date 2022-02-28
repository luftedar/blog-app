class Post < ApplicationRecord
  has_many :likes
  has_many :comments

  belongs_to :user
  after_save :update_posts_counter
  def load_last_five_comments
    comment.order('created_at Desc').limit(5)
  end

  private

  def update_posts_counter
    author.increment!(:posts_counter)
  end
end
