class RemoveLeaderMemberIdFromCommittees < ActiveRecord::Migration[7.0]
  def change
    remove_column :committees, :leader_member_id, :integer
  end
end
