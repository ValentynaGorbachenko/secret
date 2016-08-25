require 'rails_helper'

RSpec.describe Seek, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  it 'requires content' do
    seek = Seek.new
    seek.valid?
    expect(seek.errors[:content].any?).to eq(true)
  end
  describe 'relationships' do
    it 'belongs to a user' do
      user = create_user
      seek = user.seeks.create(content: 'secret 1')
      expect(seek.user).to eq(user)
    end
    it 'has many likes' do
      user1 = create_user
      user2 = create_user 'julius', 'julius@lakers.com'
      seek = user1.seeks.create(content: 'secret 1')
      like1 = Like.create(user: user1, seek: seek)
      like2 = Like.create(user: user2, seek: seek)
      expect(seek.likes).to include(like1)
      expect(seek.likes).to include(like2)
    end
  end
end
