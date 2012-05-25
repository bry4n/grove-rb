require 'faraday'

class Grove
  attr_reader :channel_key
  attr_accessor :service_name, :icon_url, :url

  GROVE_API_URI = "https://grove.io/api/notice/%s/"

  def initialize(channel_key, options = {})
    @channel_key    = channel_key
    @service_name   = options[:service] || "Grove-rb"
    @icon_url       = options[:icon_url]
    @url            = options[:url]

    @last_status    = ""
  end

  def post(message)
    options = {
      :message => message,
      :service => service_name,
      :icon_url => icon_url,
      :url => url
    }

    response      = client.post "", options
    @last_status  = response.status
  end

  def success?
    @last_status == 200
  end

  private

  def client
    @client ||= Faraday.new(:url => (GROVE_API_URI % channel_key))
  end

end
