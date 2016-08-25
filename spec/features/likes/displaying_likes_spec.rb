# displaying_likes_spec.rb
require 'rails_helper'
RSpec.describe 'displaying likes' do
  before do
    @user = create_user
    log_in @user
    @secret = @user.seeks.create(content: 'Oops')
    Like.create(user: @user, seek: @secret)
  end
  it 'displays amount of likes next to each secret' do
    visit '/seeks'
    expect(page).to have_text(@secret.content)
    expect(page).to have_text('1 likes')
    visit "/users/#{@user.id}"
    expect(page).to have_text(@secret.content)
    expect(page).to have_text('1 likes')
  end
  it "displays likes for secrets" do
    user2 = create_user 'julius', 'julius@lakers.com'
    seek1 = @user.seeks.create(content: 'secret1')
    seek2 = user2.seeks.create(content: 'secret2')
    liked_seek1 = seek1.likes.create(user: user2)
    visit '/seeks'
    expect(page).to have_text("#{seek1.likes.count} likes")
    expect(page).to have_text("#{seek2.likes.count} likes")
  end
  it "displays like button for secrets" do
    user2 = create_user 'julius', 'julius@lakers.com'
    seek1 = @user.seeks.create(content: 'secret1')
    seek2 = user2.seeks.create(content: 'secret2')
    # liked_seek1 = seek1.likes.create(user: user2)
    visit '/seeks'
    expect(page).to have_button("Like")
  end
end