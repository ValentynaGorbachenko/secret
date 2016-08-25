require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  before do
    @user = create_user
    @wrong_user = create_user 'julius', 'julius@lakers.com'
    @seek = @user.seeks.create(content: "secret")
    @seek2 = @wrong_user.seeks.create(content: 'Ooops')
    @like = @seek2.likes.create(user: @user)
  end
  describe "when not logged in" do
    before do 
      session[:user_id] = nil
    end
    it "cannot access create" do
      post :create, id: @seek
      expect(response).to redirect_to('/sessions/new')
    end
    it "cannot access destroy" do 
      delete :destroy, id: @seek
      expect(response).to redirect_to('/sessions/new')
    end
  end

  describe "when logged in as the wrong user" do
    before do
      session[:user_id] = @wrong_user.id
    end
    it "cannot unlike other user secret" do
      delete :destroy, id: @seek2
      expect(response).to redirect_to("/users/#{@wrong_user.id}")
    end
    it "can like other user secret" do
      post :create, id: @seek2
      expect(response).to redirect_to("/seeks")
    end
    it "cannot like your secret" do
      session[:user_id] = @user.id
      post :create, id: @seek2
      expect(response).to redirect_to("/users/#{@user.id}")
    end
  end
end
