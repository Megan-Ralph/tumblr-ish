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

  describe "GET #edit" do
    context "when user is not the author of the event" do
      let(:user) { create(:user) }
      let(:event) { create(:event) }

      before do
        sign_in user
      end

      it "redirects to root path and displays alert message" do
        get :edit, params: { id: event.id }
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq("You are not authorised to perform this action.")
      end
    end
  end

  describe "PUT #update" do
    context "when user is an admin" do
      let(:admin) { create(:user, admin: true) }
      let(:user) { create(:user) }
      let(:event) { create(:event, user: user) }

      before do
        sign_in admin
      end

      it "updates the event and the admin fields" do
        put :update, params: { id: event.id, event: { body: "Brand new event body!" } }
        expect(event.reload.body).to eq("Brand new event body!")
        expect(event.reload.edited_by_admin).to eq(true)
        expect(event.reload.edited_by).to eq(admin.id)
      end
    end

    context "when user is not an admin but is the author" do
      let(:user) { create(:user) }
      let(:event) { create(:event, user: user) }

      before do
        sign_in user
      end

      it "updates the event and not the admin fields" do
        put :update, params: { id: event.id, event: { body: "Brand new event body!" } }
        expect(event.reload.body).to eq("Brand new event body!")
        expect(event.reload.edited_by_admin).to eq(false)
      end
    end
  end
end
