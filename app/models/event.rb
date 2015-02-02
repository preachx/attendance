class Event < ActiveRecord::Base
  has_many :event_invitees
  has_many :invitees, :through => :event_invitees


end
