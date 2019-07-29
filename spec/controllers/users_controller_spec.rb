require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    let(:user_params) { { :user => { first_name: "Bob", last_name: "Smith", username: "bobsmith" } } }

    context "with valid attributes" do
      it "inserts the user into the database" do
        expect {
          post :create, :params => user_params
        }.to change(User, :count).by(1)
      end
      it "redirects to the home page" do
        post :create, :params => user_params
        expect(response).to redirect_to(root_url)
      end
    end
    context "with invalid attributes" do
      let(:user_params) { { :user => { first_name: "", last_name: "", username: "" } } }
      it "renders the new template" do
        post :create, :params => user_params
        expect(response).to render_template(:new)
      end
    end
  end
end
