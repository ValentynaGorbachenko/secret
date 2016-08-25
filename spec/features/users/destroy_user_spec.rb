# destroy_user_spec.rb
require 'rails_helper'
RSpec.describe 'deleting account' do
  it 'destroys user and redirects to login page' do
    user = create_user
    log_in user
    expect(current_path).to eq("/users/#{user.id}")
    click_link 'Edit Profile'
    click_button 'Delete Account'
    expect(current_path).to eq('/sessions/new')
  end
end