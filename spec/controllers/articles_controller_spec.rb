require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  describe "POST #create" do
    context "when logged in" do
      it "creates a new article" do
        user = FactoryBot.create(:user)
        sign_in user

        article_params = {
          title: "Best stew reciepe!",
          body: "This is a super test article",
          user_id: user.id
        }

        expect do
          post :create, params: { article: article_params }
        end.to change(Article, :count).by(1)

        expect(response).to redirect_to(Article.last)
      end
    end

    context "when not logged in" do
      let(:article) { FactoryBot.create(:article) }

      it "redirects to the login page" do
        article_params = {
          title: "Best Pie reciepe!",
          body: "This is a super test article"
        }

        expect do
          post :create, params: { article: article_params }
        end.to_not change(Article, :count)

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "DELETE #destroy" do
    let(:article) { create(:article) }

    context "when user is an admin" do
      before do
        sign_in create(:user, admin: true)
      end

      it "deletes the article and its comments" do
        comment1 = create(:comment, commentable: article)
        comment2 = create(:comment, commentable: article)

        expect {
          delete :destroy, params: { id: article.id }
        }.to change(Article, :count).by(-1)
        .and change(Comment, :count).by(-2)

        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "GET #edit" do
    context "when user is not the author of the article" do
      let(:user) { create(:user) }
      let(:article) { create(:article) }

      before do
        sign_in user
      end

      it "redirects to root path and displays alert message" do
        get :edit, params: { id: article.id }
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq("You are not authorised to perform this action.")
      end
    end
  end

  describe "PUT #update" do
    context "when user is an admin" do
      let(:admin) { create(:user, admin: true) }
      let(:user) { create(:user) }
      let(:article) { create(:article, user: user) }

      before do
        sign_in admin
      end

      it "updates the article and the admin fields" do
        put :update, params: { id: article.id, article: { body: "Brand new article body!" } }
        expect(article.reload.body).to eq("Brand new article body!")
        expect(article.reload.edited_by_admin).to eq(true)
        expect(article.reload.edited_by).to eq(admin.id)
      end
    end

    context "when user is not an admin but is the author" do
      let(:user) { create(:user) }
      let(:article) { create(:article, user: user) }

      before do
        sign_in user
      end

      it "updates the article and not the admin fields" do
        put :update, params: { id: article.id, article: { body: "Brand new article body!" } }
        expect(article.reload.body).to eq("Brand new article body!")
        expect(article.reload.edited_by_admin).to eq(false)
      end
    end
  end
end
