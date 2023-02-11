class CreateMemberEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :member_events do |t|
      t.integer :event_id
      t.integer :member_id
      t.boolean :approved_status
      t.date :approve_date
      t.string :approve_by

      t.timestamps
    end
  end
end
