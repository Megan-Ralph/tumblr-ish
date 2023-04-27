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
end
