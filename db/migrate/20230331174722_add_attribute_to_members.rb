class AddAttributeToMembers < ActiveRecord::Migration[7.0]
  def change
    add_column :members, :status, :boolean
  end
end
