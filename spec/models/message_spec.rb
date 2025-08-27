require 'rails_helper'

RSpec.describe Message, type: :model do
  let(:user) { User.create(name: "zain razzaq", email: "zain@example.com", password: "password123") }

  describe "validations" do
    let(:valid_message) do
      Message.new(
        content: "This is a test message",
        user: user
      )
    end

    it "is valid with valid attributes" do
      expect(valid_message).to be_valid
    end

    describe "content" do
      it "is required" do
        message = valid_message
        message.content = nil
        expect(message).not_to be_valid
      end
    end

    describe "user" do
      it "is required" do
        message = valid_message
        message.user = nil
        expect(message).not_to be_valid
      end
    end
  end

  describe "associations" do
    it "belongs to a user" do
      expect(Message.new).to respond_to(:user)
    end
  end

  describe "scopes" do
    it "has a recent scope" do
      expect(Message).to respond_to(:recent)
    end
  end
end
