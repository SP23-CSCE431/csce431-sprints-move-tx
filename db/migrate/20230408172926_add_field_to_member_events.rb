class AddFieldToMemberEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :member_events, :description, :text
  end
end
