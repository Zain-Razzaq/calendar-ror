require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    let(:valid_user) {
      User.new(name: "zain razzaq", email: "zain@example.com", password: "password123")
    }

    it "is valid with valid attributes" do
      expect(valid_user).to be_valid
    end

    describe "name" do
      it "is required" do
        user = User.new(name: nil, email: "zain@example.com", password: "password123")
        expect(user).not_to be_valid
      end

      it "can be any non-empty string" do
        user = User.new(name: "zain razzaq", email: "zain@example.com", password: "password123")
        expect(user).to be_valid
      end
    end

    describe "email" do
      it "is required" do
        user = User.new(name: "zain razzaq", email: nil, password: "password123")
        expect(user).not_to be_valid
      end

      it "must be unique" do
        User.create(name: "zain razzaq", email: "zain@example.com", password: "password123")
        user = User.new(name: "zain razzaq 2", email: "zain@example.com", password: "password1234")
        expect(user).not_to be_valid
      end

      it "must have valid email format" do
        valid_emails = [ "zain@example.com", "abc.zain@abc.com", "zain3232@abc.org" ]
        valid_emails.each do |email|
          user = User.new(name: "zain razzaq", email: email, password: "password123")
          expect(user).to be_valid
        end
      end

      it "rejects invalid email formats" do
        invalid_emails = [ "invalid", "@example.com", "zain@", "zain.example.com", "zain@.com" ]
        invalid_emails.each do |email|
          user = User.new(name: "zain", email: email, password: "password123")
          expect(user).not_to be_valid
        end
      end
    end

    describe "password" do
      it "is required" do
        user = User.new(name: "zain razzaq", email: "zain@example.com", password: nil)
        expect(user).not_to be_valid
      end

      it "must be at least 6 characters long" do
        user = User.new(name: "zain razzaq", email: "zain@example.com", password: "12345")
        expect(user).not_to be_valid
      end

      it "accepts passwords 6 characters or longer" do
        user = User.new(name: "zain razzaq", email: "zain@example.com", password: "123456")
        expect(user).to be_valid
      end
    end
  end


  describe "password authentication" do
    it "can authenticate with correct password" do
      user = User.create(name: "zain razzaq", email: "zain@example.com", password: "password123")
      expect(user.authenticate("password123")).to eq(user)
    end

    it "cannot authenticate with incorrect password" do
      user = User.create(name: "zain razzaq", email: "zain@example.com", password: "password123")
      expect(user.authenticate("wrongpassword")).to be_falsey
    end
  end
end
