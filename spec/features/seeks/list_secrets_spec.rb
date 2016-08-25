# list_secrets_spec.rb
require 'rails_helper'
RSpec.describe 'user profile page' do
  before do
    @user = create_user
    log_in @user
  end
  it "displays a user's secrets on profile page" do
    seek = @user.seeks.create(content: 'secret')
    visit "/users/#{@user.id}"
    expect(page).to have_text("#{seek.content}")
    # have_link - for the ancor tag
    # have_button - for the form
    expect(page).to have_button("Delete")
    expect(page).to have_text("#{seek.likes.count} likes")
  end
  it "displays a user's liked secrets on profile page" do
    user = create_user 'julius', 'julius@lakers.com'
    seek = user.seeks.create(content: 'secret of user')
    liked_seek = seek.likes.create(user: @user)
    # liked_seek = Like.create(user: @user, seek: seek)
    visit "/users/#{@user.id}"
    expect(page).to have_text("#{seek.content}")
    expect(page).to have_text("#{seek.likes.count} likes")
    # check for the button Create Secret, should be moved into the separate rspec
    expect(page).to have_button("Create Secret")
  end
  it "displays everyone's secrets" do
    user2 = create_user 'julius', 'julius@lakers.com'
    seek1 = @user.seeks.create(content: 'secret1')
    seek2 = user2.seeks.create(content: 'secret2')
    visit '/seeks'
    expect(page).to have_text(seek1.content)
    expect(page).to have_text(seek2.content)
  end
  
end