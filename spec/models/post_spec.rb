require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'Post model' do
    user = User.create(name: 'Orçun', bio: 'bio')
    subject do
      Post.new(title: 'First post', text: 'First Fail:(', user_id: user)
    end
    before { subject.save }

    it 'check title is not blank' do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it 'check title exceeding 250 characters' do
      subject.title = 'Lorem ipsum dolor sit amet,
      consectetur adipiscing elit.
      Etiam volutpat arcu eu neque ullamcorper,
      ornare porta mi tincidunt. Morbi quis sodales orci.
      Praesent id metus magna. Nulla non orci dignissim,
      semper metus id, egestas augue.
      Pellentesque non enim non orci hendrerit accumsan
      ornare ac mauris.
      Pellentesque non urna eu tortor.'
      expect(subject).to_not be_valid
    end

    it 'check likes counter is greater than or equal to 0' do
      subject.likes_counter = -1
      expect(subject).to_not be_valid
    end

    it 'loads only the recent 5 comments' do
      expect(subject.recent_comments).to eq(subject.comments.last(5))
    end
  end
end
