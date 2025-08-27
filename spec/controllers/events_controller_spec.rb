require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  let(:user) { User.create(name: "zain razzaq", email: "zain@example.com", password: "password123") }

  before do
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe "GET #index" do
    it "returns a successful response" do
      get :index
      expect(response).to be_successful
    end

    it "assigns a new event" do
      get :index
      expect(assigns(:event)).to be_a_new(Event)
    end
  end

  describe "GET #new" do
    it "returns a successful response" do
      get :new
      expect(response).to be_successful
    end

    it "assigns a new event" do
      get :new
      expect(assigns(:event)).to be_a_new(Event)
    end

    context "with date parameter" do
      it "sets the date when date param is present" do
        get :new, params: { date: "2024-01-15" }
        expect(assigns(:event).date).to eq(Date.parse("2024-01-15"))
      end
    end
  end

  describe "POST #create" do
    let(:valid_params) do
      {
        event: {
          title: "Test Event",
          desc: "This is a test event description",
          date: Date.today,
          start_time: Time.current,
          end_time: Time.current + 1.hour
        }
      }
    end

    context "with valid parameters" do
      it "creates a new event" do
        expect {
          post :create, params: valid_params
        }.to change(Event, :count).by(1)
      end

      it "redirects to root path" do
        post :create, params: valid_params
        expect(response).to redirect_to(root_path)
      end
    end

    context "with invalid parameters" do
      let(:invalid_params) do
        {
          event: {
            title: "",
            desc: "",
            date: nil,
            start_time: nil,
            end_time: nil
          }
        }
      end

      it "does not create a new event" do
        expect {
          post :create, params: invalid_params
        }.not_to change(Event, :count)
      end
    end
  end
end
