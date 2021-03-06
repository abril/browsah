$LOAD_PATH << "../lib" << "lib"
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
