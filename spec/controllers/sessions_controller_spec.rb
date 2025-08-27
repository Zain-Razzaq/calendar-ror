require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let(:user) { User.create(name: "zain razzaq", email: "zain@example.com", password: "password123") }

  describe "GET #new" do
    it "returns a successful response" do
      get :new
      expect(response).to be_successful
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    context "with valid credentials" do
      let(:valid_params) do
        {
          email: "zain@example.com",
          password: "password123"
        }
      end
    end

    context "with invalid credentials" do
      let(:invalid_params) do
        {
          email: "zain@example.com",
          password: "wrongpassword"
        }
      end

      it "redirects to login path with alert" do
        post :create, params: invalid_params
        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe "DELETE #destroy" do
    it "redirects to root path with success notice" do
      delete :destroy
      expect(response).to redirect_to(root_path)
    end
  end
end
