class Post < ApplicationRecord
  has_many :likes
  has_many :comments

  belongs_to :author, class_name: 'User', foreign_key: :user_id

  private

  def update_posts_counter
    author.increment!(:posts_counter)
  end
end
