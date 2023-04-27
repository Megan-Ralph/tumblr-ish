require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  describe "POST #create" do
    context "when logged in" do
      let(:user) { FactoryBot.create(:user) }
      let(:article) { FactoryBot.create(:article) }
    
      before do
        sign_in user
        post :create, xhr: true, params: { like: {likeable_type: "Article", likeable_id: article.id}, user_id: user.id }
      end

      it "returns successful like creation" do
        expect(response).to be_successful
      end
    end
  end
end
