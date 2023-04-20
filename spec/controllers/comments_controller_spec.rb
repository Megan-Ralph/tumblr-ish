require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  describe "POST #create" do
    context "when logged in" do
      let(:user) { FactoryBot.create(:user) }
      let(:article) { FactoryBot.create(:article) }
      let(:event) { FactoryBot.create(:event) }
    
      before do
        sign_in user
      end

      context "when crearing a comment for an article" do
        it "creates a new comment for this article" do
          comment_params = {
            body: "This is a comment!",
            commentable_type: "Article",
            commentable_id: article.id
          }

          expect do
            post :create, params: { comment: comment_params }
          end.to change(Comment, :count).by(1)

          expect(response).to redirect_to(article_path(article))
        end
      end

      context "when creating a comment for an event" do
        it "creates a new comment for this event" do
          comment_params = {
            body: "This is a comment!",
            commentable_type: "Event",
            commentable_id: event.id
          }

          expect do
            post :create, params: { comment: comment_params }
          end.to change(Comment, :count).by(1)

          expect(response).to redirect_to(event_path(event))
        end
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
