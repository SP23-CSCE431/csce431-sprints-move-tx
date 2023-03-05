require 'rails_helper'
require 'support/member_user'

RSpec.describe "Member's View based on position", type: :feature do

  include_context 'member user'

  describe 'Member' do

    scenario 'Visit Members List' do
      visit root_path
      expect(current_path).to eq '/'
    end
  end
end
