class AddPhotoToInvitees < ActiveRecord::Migration
  def self.up
    add_attachment :invitees, :photo
  end

  def self.down
    remove_attachment :invitees, :photo
  end
end
