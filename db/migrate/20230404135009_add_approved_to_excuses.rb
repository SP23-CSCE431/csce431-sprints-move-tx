class AddApprovedToExcuses < ActiveRecord::Migration[7.0]
  def change
    add_column :excuses, :approved, :boolean
  end
end
