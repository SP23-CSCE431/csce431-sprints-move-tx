class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :name
      t.date :date
      t.string :point_type
      t.string :event_type
      t.string :phrase

      t.timestamps
    end
  end
end
