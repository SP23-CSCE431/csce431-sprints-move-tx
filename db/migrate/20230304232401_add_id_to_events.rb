class AddIdToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :cal_event_id, :string
  end
end
