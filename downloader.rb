require 'googleauth'
require 'typhoeus'

class Downloader
  CREDENTIAL_STORE_FILE = "oauth2.json"
  SCOPES = ['https://spreadsheets.google.com/feeds']
  SHEET_ID = "1jzvr15xytl0LG4MffjtCbUXJPPKq5YDozi5i77vZrvg"

  def initialize
  end

  def bar
    authorization = Google::Auth.get_application_default(SCOPES)
puts authorization.apply({})
    puts Typhoeus.get(
      "https://spreadsheets.google.com/feeds/spreadsheets/private/full",
      headers: authorization.apply({}),
    ).body
  end
end

Downloader.new.bar

