require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  describe "POST #create" do
    context "When logged in" do
      it "creates a new event" do
        user = FactoryBot.create(:user)
        sign_in user

        event_params = {
          title: "Fan Fest!",
          body: "This is a super test event",
          start_date: DateTime.now,
          end_date: DateTime.now + 4.hours,
          user_id: user.id
        }

        expect do
          post :create, params: { event: event_params }
        end.to change(Event, :count).by(1)

        expect(response).to redirect_to(Event.last)
      end
    end

    context "when not logged in" do
      let(:event) { FactoryBot.create(:event) }

      it "redirects to the login page" do
        event_params = {
          title: "Fan Fest!",
          body: "This is a super test event",
          start_date: DateTime.now,
          end_date: DateTime.now + 4.hours
        }

        expect do
          post :create, params: { event: event_params }
        end.to_not change(Event, :count)

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "DELETE #destroy" do
    let(:event) { create(:event) }

    context "when user is an admin" do
      before do
        sign_in create(:user, admin: true)
      end

      it "deletes the event and its comments" do
        comment1 = create(:comment, commentable: event)
        comment2 = create(:comment, commentable: event)

        expect {
          delete :destroy, params: { id: event.id }
        }.to change(Event, :count).by(-1)
        .and change(Comment, :count).by(-2)

        expect(response).to redirect_to(root_path)
      end
    end
  end
end
