require 'sinatra'

require_relative 'lib/hootsuite'

enable :sessions

get "/" do
  base_url = 'https://platform.hootsuite.com/oauth2/auth'
  client_id = ENV['CLIENT_ID']
  redirect_uri = ENV['REDIRECT_URI']

  if session[:access_token]
    "
      <h2>Hootsuite Access Token</h2>
      <p>#{session[:access_token]}</p>
    "
  else
    url = "#{base_url}?response_type=code&client_id=#{client_id}&redirect_uri=#{redirect_uri}"

    "<a href=#{url}>Connect with Hootsuite</a>"
  end
end

get "/oauth/callback" do
  code = request.params['code']

  # second need to make request to https://platform.hootsuite.com/oauth2/token
  response = Hootsuite::Oauth::Authenticate.new(code).request

  session[:access_token] = response[:access_token]
  session[:refresh_token] = response[:refresh_token]

  "
    Codigo: <p>#{code}</p>

    Token: <p>#{response[:access_token]}</p>

    refresh: <p>#{response[:refresh_token]}</p>
  "
end
