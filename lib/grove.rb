require 'faraday'

class Grove
  attr_reader :channel_key, :last_status
  attr_accessor :service, :icon_url, :url

  GROVE_API_URI = "https://grove.io/api/notice/%s/"
  DEFAULT_SERVICE_NAME = 'Grove-rb'

  def initialize(channel_key, options = {})
    @channel_key    = channel_key
    @service   = options[:service] || DEFAULT_SERVICE_NAME
    @icon_url       = options[:icon_url]
    @url            = options[:url]
  end

  def channel_key=(new_channel_key)
    @client = nil
    @channel_key = new_channel_key
  end

  def post(message)
    options = {
      :message => message,
      :service => service,
      :icon_url => icon_url,
      :url => url
    }

    options = options.delete_if { |k,v| v.nil? }

    client.post "", options
  end

  def success?
    @last_status == 200
  end

  private

  def client
    @client ||= Faraday.new(:url => (GROVE_API_URI % channel_key))
  end

end
