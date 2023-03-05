class AddPhraseToMemberEvent < ActiveRecord::Migration[7.0]
  def change
    add_column :member_events, :phrase, :string
  end
end
