class EventSerializer < ActiveModel::Serializer
  attributes :id, :title, :desc, :date, :start_time, :end_time

  belongs_to :user
end
