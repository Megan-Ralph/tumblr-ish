require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  describe "POST #create" do
    context "when logged in" do
      let(:user) { FactoryBot.create(:user) }
      let(:article) { FactoryBot.create(:article) }
    
      before do
        sign_in user
        post :create, xhr: true, params: { comment: {body: "Test comment", commentable_type: "Article", commentable_id: article.id}, user_id: user.id }
      end

      it "returns successful comment creation" do
        expect(response).to be_successful
      end
    end

    context "when not logged in" do
      let(:article) { FactoryBot.create(:article) }
      it "redirects to the login page" do
        comment_params = {
          body: "This is a comment!",
          commentable_type: "Article",
          commentable_id: article.id
        }

        expect do
          post :create, params: { comment: comment_params }
        end.to_not change(Comment, :count)

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
