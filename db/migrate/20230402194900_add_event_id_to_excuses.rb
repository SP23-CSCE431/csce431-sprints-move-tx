class AddEventIdToExcuses < ActiveRecord::Migration[7.0]
  def change
    add_reference :excuses, :event, foreign_key: true
  end
end
