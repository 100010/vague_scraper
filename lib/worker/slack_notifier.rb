require 'net/http'

class SlackNotifier
  WEBHOOK_URL = ENV['slack_webhok_url']

  def perform(title, icon, message)
    uri = URI SlackNotifier::WEBHOOK_URL

    contents = "```\n" + message + "\n```"
    hash = {
      "payload" => {
        "username"   => title,
        "text"       => contents,
        "icon_emoji" => icon,
      }.to_json
    }
    Net::HTTP.post_form(uri, hash)
  end
end
