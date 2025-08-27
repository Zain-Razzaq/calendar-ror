require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #new" do
    it "returns a successful response" do
      get :new
      expect(response).to be_successful
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end

    it "assigns a new user" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "POST #create" do
    let(:valid_params) do
      {
        user: {
          name: "zain razzaq",
          email: "zain@example.com",
          password: "password123"
        }
      }
    end

    context "with valid parameters" do
      it "creates a new user" do
        expect {
          post :create, params: valid_params
        }.to change(User, :count).by(1)
      end
    end

    context "with invalid parameters" do
      let(:invalid_params) do
        {
          user: {
            name: "",
            email: "",
            password: ""
          }
        }
      end

      it "does not create a new user" do
        expect {
          post :create, params: invalid_params
        }.not_to change(User, :count)
      end
    end
  end
end
