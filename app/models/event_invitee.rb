class EventInvitee < ActiveRecord::Base
  belongs_to :invitee
  belongs_to :event
end
