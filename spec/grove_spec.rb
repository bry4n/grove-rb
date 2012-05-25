require File.dirname( __FILE__ ) + '/../lib/grove-rb'

describe Grove do
  let(:channel_key) { '12345678901234567890123456789012' }
  let(:client) { stub }

  context "when initializing" do
    it "should set the channel_key" do
      g = Grove.new(channel_key)

      g.channel_key.should == channel_key
    end

    it "should set the service" do
      g = Grove.new(channel_key, :service => 'asdf')

      g.service.should == 'asdf'
    end

    it "should have a default service" do
      g = Grove.new(channel_key)

      g.service.should == 'Grove-rb'
    end

    it "should set the icon_url" do
      icon_url = 'http://domain.com/image.jpg'

      g = Grove.new(channel_key, :icon_url => icon_url)

      g.icon_url.should == icon_url
    end

    it "should set the url" do
      url = 'http://domain.com'

      g = Grove.new(channel_key, :url => url)

      g.url.should == url
    end

  end

  context "when modifying existing attributes" do
    let(:g) { Grove.new( channel_key )}

    it "should set service" do
      lambda { g.service = 'new servicename' }.should change { g.service }
    end

    it "should set icon_url" do
      lambda { g.icon_url = 'new icon url' }.should change { g.icon_url }
    end

    it "should set url" do
      lambda { g.url = 'new url' }.should change { g.url }
    end

    context "when changing the channel_key" do

      it "should use the new key with calls" do
        Faraday.should_receive(:new).and_return { client }
        client.should_receive(:post).at_least(:once)
        g.post('hi')

        new_channel_key = channel_key.reverse

        g.channel_key = new_channel_key

        Faraday.should_receive(:new).with { |options|
          options[:url].should match %r{#{new_channel_key}}
        }.and_return(client)

        g.post('hi')
      end

      it "should use the new key with calls" do
        g = Grove.new(channel_key)

        lambda { g.channel_key = 'asdf' }.should change { g.channel_key }
      end

    end
  end

  context "posting messages" do

    it "should put the message in the options" do
      Faraday.stub(:new).and_return(client)
      client.should_receive(:post).with('', { :message => 'asdf', :service => Grove::DEFAULT_SERVICE_NAME })
      Grove.new(channel_key).post('asdf')
    end

    it "should post to the correct API url" do
      Faraday.should_receive(:new).with( :url => (Grove::GROVE_API_URI % channel_key)).and_return(client)
      client.should_receive(:post)
      Grove.new(channel_key).post('hi')
    end
  end
end
