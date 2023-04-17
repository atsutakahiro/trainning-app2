require 'line/bot'

LineBotApi = Line::Bot::Client.new do |config|
  config.channel_secret = ENV['LINE_CHANNEL_SECRET']
  config.channel_token = ENV['LINE_CHANNEL_ACCESS_TOKEN']
end
