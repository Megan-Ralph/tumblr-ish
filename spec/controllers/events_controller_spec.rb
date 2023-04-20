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
end
