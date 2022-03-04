require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'User model' do
    subject { User.new(name: 'Amy', photo: 'Tom.png', bio: 'bio', posts_counter: 0) }
    before { subject.save }

    it 'Check the name is not blank' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'check if the posts_counter numeric' do
      subject.posts_counter = ''
      expect(subject).to_not be_valid
    end

    it 'check if the posts_counter greater than or equal to zero' do
      expect(subject.posts_counter).to be >= 0
    end
  end

  describe 'validates recent posts method' do
    before do
      4.times do |post|
        Post.create(user_id: subject, title: "This is post #{post}", text: 'Lorem ipsum laoessh, riahe')
      end
    end

    it 'shows three recent posts' do
      expect(subject.recent_three_posts).to eq(subject.posts.last(3))
    end
  end
end
