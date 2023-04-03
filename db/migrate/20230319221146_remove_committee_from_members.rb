class RemoveCommitteeFromMembers < ActiveRecord::Migration[7.0]
  def change
    remove_column :members, :committee, :string
  end
end
