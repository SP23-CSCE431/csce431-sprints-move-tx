require 'rails_helper'
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
      get '/admins/auth/google_oauth2/callback'
    end
  end

