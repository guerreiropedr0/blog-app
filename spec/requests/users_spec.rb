require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /index" do
    before(:example) { get users_path }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "renders template" do
      expect(response).to render_template(:index)
    end

    it "renders placeholder text" do
      expect(response.body).to include 'Welcome to Blog App'
    end
  end

  describe "GET /show" do
    before(:example) do
      @user = User.create(name: 'Pedro Guerreiro', photo: 'random_link.png', bio: 'I\'m creating a test right now!')
      get user_path(@user.id)
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "renders template" do
      expect(response).to render_template(:show)
    end

    it "renders placeholder text" do
      expect(response.body).to include 'Bio'
    end
  end
end
