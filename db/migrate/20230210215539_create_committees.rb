class CreateCommittees < ActiveRecord::Migration[7.0]
  def change
    create_table :committees do |t|
      t.string :name
      t.integer :leader_member_id

      t.timestamps
    end
  end
end
