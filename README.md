# Grove.io Client for Ruby

### Install

add this line to your Gemfile

    gem 'grove-rb'

Just read the 2 LOC then you will be fine.

``` ruby
# grovebot.rb
grove = Grove.new(GROVE_CHANNEL_KEY, :service => 'myGroveClient', :icon_url => 'http://example.com/icon.png')
grove.post "Hello World!"
```

