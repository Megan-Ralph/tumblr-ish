require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #index" do
    context "when logged in" do
      it "returns a successful response and renders all users" do
        user = FactoryBot.create(:user)
        sign_in user
  
        get :index, format: :html
        expect(response).to be_successful
        expect(response.body).to include(user.email)
      end
    end

    context "when not logged in" do
      it "redirects to the login page" do
        get :index, format: :html

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "GET #show" do
    context "when logged in" do
      it "returns a successful response and renders user" do
        user = FactoryBot.create(:user)
        sign_in user

        get :show, params: { id: user.id }, format: :html
        expect(response).to be_successful
        expect(response.body).to include("Hello")
      end

      it "displays the user's activity feed" do
        user = FactoryBot.create(:user)

        FactoryBot.create_list(:article, 5, user: user)
        FactoryBot.create_list(:event, 3, user: user)
        FactoryBot.create_list(:comment, 2, commentable: FactoryBot.create(:article, user: user), user: user)
        sign_in user

        get :show, params: { id: user.id }

        expect(user.activity_feed.count).to eq(10)
        expect(response).to render_template(:show)
      end

      it "displays posts created by user" do
        user = FactoryBot.create(:user)
        article = FactoryBot.create(:article, user_id: user.id)
        sign_in user

        get :show, params: { id: user.id }, format: :html
        expect(response).to be_successful
        expect(response.body).to include(article.title)
        expect(response.body).to include(article.body)
      end
    end
  end
end
