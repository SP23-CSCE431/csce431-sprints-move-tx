require 'google/apis/calendar_v3'
require 'googleauth'
require 'googleauth/stores/file_token_store'

OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'.freeze
APPLICATION_NAME = 'My Calendar App'.freeze
CREDENTIALS_PATH = 'cal_service_account.json'.freeze
TOKEN_PATH = 'path/to/token.yaml'.freeze
# Initialize the Google Calendar API client
CALENDAR = Google::Apis::CalendarV3::CalendarService.new
CALENDAR.client_options.application_name = APPLICATION_NAME
CALENDAR.authorization = Google::Auth::ServiceAccountCredentials.make_creds(
  json_key_io: File.open(CREDENTIALS_PATH),
  scope: Google::Apis::CalendarV3::AUTH_CALENDAR,
  # Set the email address of the user you want to impersonate
  # in the calendar API requests
  sub: 'calendar@admin-dashboard-378505.iam.gserviceaccount.com'
)
