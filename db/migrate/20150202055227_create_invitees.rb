class CreateInvitees < ActiveRecord::Migration
  def change
    create_table :invitees do |t|

      t.string :name,              null: false
      t.string :family_name
      t.string :category
      t.string :region
      t.string :contact_number

      t.timestamps
    end
  end
end
