class AddCommitteeToMembers < ActiveRecord::Migration[7.0]
  def change
    add_reference :members, :committee, foreign_key: true
  end
end
