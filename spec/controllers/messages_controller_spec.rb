require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  let(:user) { User.create(name: "zain razzaq", email: "zain@example.com", password: "password123") }

  before do
    # Mock the current_user method to return our test user
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe "GET #index" do
    it "returns a successful response" do
      get :index
      expect(response).to be_successful
    end

    it "assigns recent messages" do
      get :index
      expect(assigns(:messages)).to eq(Message.recent)
    end

    it "assigns a new message" do
      get :index
      expect(assigns(:message)).to be_a_new(Message)
    end
  end

  describe "POST #create" do
    let(:valid_params) do
      {
        message: {
          content: "This is a test message"
        }
      }
    end

    context "with valid parameters" do
      it "creates a new message" do
        expect {
          post :create, params: valid_params
        }.to change(Message, :count).by(1)
      end

      it "returns ok status" do
        post :create, params: valid_params
        expect(response).to have_http_status(:ok)
      end
    end

    context "with invalid parameters" do
      let(:invalid_params) do
        {
          message: {
            content: ""
          }
        }
      end

      it "does not create a new message" do
        expect {
          post :create, params: invalid_params
        }.not_to change(Message, :count)
      end

      it "returns unprocessable entity status" do
        post :create, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
