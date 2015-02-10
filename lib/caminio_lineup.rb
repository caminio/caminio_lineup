require "caminio_lineup/version"

# workaround for the following LineupEvent senders
# to keep compatibility with development mode when starting
# a rails server
if Rails.env == 'development'
  require File::join File::dirname(__FILE__), '../../caminio/app/models/location'
end

require "caminio_lineup/engine"
require "caminio_lineup/lineup_attributes"
