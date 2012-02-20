require 'faraday'

class Grove
  attr_accessor :channel_key, :service_name

  GROVE_API_URI = "https://grove.io/api/notice/%s/"

  def initialize(channel_key, service_name = nil)
    @channel_key    = channel_key
    @service_name   = service_name || "Grove-rb"
    @last_status    = ""
  end

  def post(message)
    response      = client.post "", {:service => service_name, :message => message}
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
