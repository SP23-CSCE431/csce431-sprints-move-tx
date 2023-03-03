class AddMemberToCommittee < ActiveRecord::Migration[7.0]
  def change
    add_reference :committees, :member, foreign_key: true
  end
end
