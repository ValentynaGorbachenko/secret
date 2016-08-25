require 'rails_helper'

RSpec.describe SeeksController, type: :controller do
  before do
    @user = create_user
    @seek = @user.seeks.create(content: "secret")
  end
  describe "when not logged in" do
    before do
      session[:user_id] = nil
    end
    it "cannot access index" do
      get :index
      expect(response).to redirect_to('/sessions/new')
    end
    it "cannot access create" do
      post :create
      expect(response).to redirect_to('/sessions/new')
    end
    it "cannot access destroy" do
      delete :destroy, id: @seek
      expect(response).to redirect_to('/sessions/new')
    end
  end
end
