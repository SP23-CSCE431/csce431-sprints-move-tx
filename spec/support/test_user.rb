require 'rails_helper'

# This is a helper file for our test. The main purpose is to help the test gain oauth acess. Might have more uses in the future

# function is used to set up oauth before each integration test
shared_context "test user" do
    before(:each) do
      OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
        provider: "google_oauth2",
        uid: "110141928142400027216",
        info: {
          full_name: "Jerry Moody",
          email: "waylandmoody55@tamu.edu",
          avatar_url: "ttps://lh3.googleusercontent.com/a/AEdFTp7UsnwxgB_OIuTYM-Y-ZDDYUaVlD6w9nitamNJ7=s96-c"
        },
      })
      OmniAuth.config.test_mode = true
      visit "/admins/sign_in"
      click_on "Sign in with Google"
      visit new_member_path
      fill_in "member[name]", with: "wayland"
      fill_in "member[committee]", with: "Outreach"
      click_on "Create Member"
      click_on "Edit"
      fill_in "member[position]", with: "President"
      click_on "Update Member"
    end
  end

  # function is used to set up oath before each request test 
  shared_context "test user requests" do
    before(:each) do
      OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
        provider: "google_oauth2",
        uid: "110141928142400027216",
        info: {
          full_name: "Jerry Moody",
          email: "waylandmoody55@tamu.edu",
          avatar_url: "ttps://lh3.googleusercontent.com/a/AEdFTp7UsnwxgB_OIuTYM-Y-ZDDYUaVlD6w9nitamNJ7=s96-c"
        },
      })

      OmniAuth.config.test_mode = true
      admin = Admin.create!(email: "waylandmoody55@tamu.edu", full_name: "Jerry Moody", id: 1)
      event = Event.create!(name: "christmas at the park", id: 1, event_type: "Service", date: Date.parse("2022-01-01"), point_type: "Outreach")
      member = Member.create!(position: "Vice President", id: 1, name: "wayland", admin_id: 1)
      member_event =  MemberEvent.create(id: 1, member_id: 1, event_id: 1)
      get '/admins/auth/google_oauth2/callback'

    end
  end

  # function is used to set up oath before each view test
  shared_context "admin oauth for views" do
  before() do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      provider: "google_oauth2",
      uid: "110141928142400027216",
      info: {
        full_name: "Jerry Moody",
        email: "waylandmoody55@tamu.edu",
        avatar_url: "ttps://lh3.googleusercontent.com/a/AEdFTp7UsnwxgB_OIuTYM-Y-ZDDYUaVlD6w9nitamNJ7=s96-c"
      },
    })
    current_admin = Admin.create!(email: "waylandmoody55@tamu.edu", full_name: "Jerry Moody", id: 1) # create an admin for testing
    allow(view).to receive(:current_admin).and_return(current_admin) # stub current_admin method
    user = Member.create!(position: "Vice President", id: 1, name: "wayland", admin_id: 1) # create a member with the admin as its foreign key
    assign(:member, user) # assign the member to @member
    assign(:user, user)
  end
end
