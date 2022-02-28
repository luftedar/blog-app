class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :user_id
  belongs_to :post

  def update_comments_counter
    Post.increment!(:comments_counter)
  end
end
