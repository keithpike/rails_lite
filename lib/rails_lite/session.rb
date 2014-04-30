require 'json'
require 'webrick'

class Session
  # find the cookie for this app
  # deserialize the cookie into a hash
  def initialize(req)
    my_cookies = req.cookies.select { |cookie| cookie.name == '_rails_lite_app' }
    my_cookie_values = my_cookies.map { |cookie| JSON.parse(cookie.value) }
    @session = my_cookie_values.first || Hash.new
  end

  def [](key)
    @session[key]
  end

  def []=(key, val)
    @session[key] = val
  end

  # serialize the hash into json and save in a cookie
  # add to the responses cookies
  def store_session(res)
    res.cookies << WEBrick::Cookie.new('_rails_lite_app', @session.to_json )
  end
end
