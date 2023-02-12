class CreateMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :members do |t|
      t.string :name
      t.string :committee
      t.string :position
      t.integer :civicPoints
      t.integer :outreachPoints
      t.integer :socialPoints
      t.integer :marketingPoints
      t.integer :totalPoints

      t.timestamps
    end
  end
end
