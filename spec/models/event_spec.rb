require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:user) { User.create(name: "zain razzaq", email: "zain@example.com", password: "password123") }

  describe "validations" do
    let(:valid_event) do
      Event.new(
        title: "Test Event",
        date: Date.today,
        start_time: Time.current,
        end_time: Time.current + 1.hour,
        desc: "This is a test event description",
        user: user
      )
    end

    it "is valid with valid attributes" do
      expect(valid_event).to be_valid
    end

    describe "title" do
      it "is required" do
        event = valid_event
        event.title = nil
        expect(event).not_to be_valid
      end

      it "must be at least 3 characters long" do
        event = valid_event
        event.title = "ab"
        expect(event).not_to be_valid
      end
    end

    describe "date" do
      it "is required" do
        event = valid_event
        event.date = nil
        expect(event).not_to be_valid
      end
    end

    describe "start_time" do
      it "is required" do
        event = valid_event
        event.start_time = nil
        expect(event).not_to be_valid
      end
    end

    describe "end_time" do
      it "is required" do
        event = valid_event
        event.end_time = nil
        expect(event).not_to be_valid
      end
    end

    describe "desc" do
      it "is required" do
        event = valid_event
        event.desc = nil
        expect(event).not_to be_valid
      end

      it "must be at least 5 characters long" do
        event = valid_event
        event.desc = "abcd"
        expect(event).not_to be_valid
      end
    end
  end

  describe "custom validations" do
    it "validates end_time is after start_time" do
      event = Event.new(
        title: "Test Event",
        date: Date.today,
        start_time: Time.current + 1.hour,
        end_time: Time.current,
        desc: "This is a test event description",
        user: user
      )
      expect(event).not_to be_valid
    end
  end

  describe "associations" do
    it "belongs to a user" do
      expect(Event.new).to respond_to(:user)
    end
  end
end
