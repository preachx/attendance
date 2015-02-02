class CreateEventInvitees < ActiveRecord::Migration
  def change
    create_table :event_invitees do |t|

      t.integer :invitee_id
      t.integer :event_id
      t.integer :number_of_people_invited
      t.integer :number_of_people_brought

      t.timestamps
    end
  end
end
