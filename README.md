# It's a REAL BROWSAH!!!1!
[![Build Status](https://secure.travis-ci.org/abril/browsah.png)](http://travis-ci.org/abril/browsah)

Unlike other HTTP client libraries, `browsah` aims to be a true browser.

*fair warning*: Since `browsah` depends on [em-http-request](http://rubygems.org/gems/em-http-request) and [em-synchrony](http://rubygems.org/gems/em-synchrony), thus is Ruby 1.9.x only.

## Examples
For more examples, see [examples](https://github.com/abril/browsah/tree/master/examples).

### Simple POST/GET:

```ruby
require 'browsah'
require 'json'

headers = { 'Content-Type' => 'application/json' }
body    = { "longUrl" => "http://engineering.abril.com.br" }.to_json
bw      = Browsah.new('https://www.googleapis.com')

bw.post '/urlshortener/v1/url', :body => body, :headers => headers do |r|
  r.on(200) do
    parsed = JSON.parse(r.body)
    jj parsed
  end
end

bw.get '/urlshortener/v1/url?shortUrl=http://goo.gl/TT1LT' do |r|
  r.on(200) do
    parsed = JSON.parse(r.body)
    jj parsed
  end
end
```

## License
[MIT License](http://opensource.org/licenses/MIT). Copyright (c) 2011 Abril Midia.

See LICENSE for details.
