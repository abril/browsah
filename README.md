# It's a REAL BROWSAH!!!1!

Unlike other HTTP client libraries, `browsah` aims to be a true browser.

[![Build Status](https://secure.travis-ci.org/abril/browsah.png)](http://travis-ci.org/abril/browsah)

# Sample Code
## Simple POST/GET:

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

# License

browsah is licensed under the [BSD License](http://opensource.org/licenses/BSD-2-Clause).

See LICENSE file for details.
