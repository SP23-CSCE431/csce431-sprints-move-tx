class CreateExcuses < ActiveRecord::Migration[7.0]
  def change
    create_table :excuses do |t|
      t.text :description

      t.timestamps
    end
  end
end
