class AddMemberIdToExcuses < ActiveRecord::Migration[7.0]
  def change
    add_reference :excuses, :member, foreign_key: true
  end
end
