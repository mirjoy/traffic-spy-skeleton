require './test/test_helper.rb'

class ApplicationDetailsTest < Minitest::Test
  include Rack::Test::Methods
  include Capybara::DSL

  def app
    TrafficSpy::Server
  end

  def setup
    super
    @identifier = Identifier.create(name: 'yahoo', root_url: 'yahoo.com')
    setup_yahoo
    visit '/sources/yahoo'
  end

  def test_it_displays_the_browsers
    assert_equal '/sources/yahoo', current_path
    assert page.has_content?("Safari")
    assert page.has_content?("Chrome")
  end

  def test_it_displays_the_browsers
    assert page.has_content?("Safari")
    assert page.has_content?("Chrome")
  end

  def test_it_displays_the_OS
    assert page.has_content?("Macintosh")
    assert page.has_content?("Windows")
  end

  def test_it_displays_the_scree_res
    assert page.has_content?("1000 x 1000")
    assert page.has_content?("800 x 600")
  end

  def test_it_displays_most_to_least_hits
    assert page.has_content?("http://yahoo.com/weather")
    assert page.has_content?("3")
  end

  def test_it_displays_least_to_most_response_time
    assert page.has_content?("http://yahoo.com/weather")
    assert page.has_content?("Pages by average response time")
    assert page.has_content?("10")
  end

  def test_it_displays_events_link
    assert page.find_link "yahoo Events"
  end

  def test_it_displays_relative_links
    assert page.find_link 'yahoo.com/chat_room'
    assert page.find_link 'yahoo.com/not_news'
    assert page.find_link 'yahoo.com/weather'
  end

  def setup_yahoo
    @payload_1 = 'payload={"url":"http://yahoo.com/weather","requestedAt":"2013-01-13 21:38:28 -0700","respondedIn":37,"referredBy":"http://apple.com","requestType":"GET","parameters":["what","huh"],"eventName": "socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"800","resolutionHeight":"600","ip":"63.29.38.214"}'
    @payload_2 = 'payload={"url":"http://yahoo.com/weather","requestedAt":"2013-01-13 22:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":["what","huh"],"eventName": "beginRegistration","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"500","resolutionHeight":"700","ip":"63.29.38.214"}'
    @payload_3 = 'payload={"url":"http://yahoo.com/weather","requestedAt":"2013-01-13 12:38:28 -0700","respondedIn":200,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":["slow"],"eventName": "socialLogin","userAgent":"Mozilla/5.0 (Windows%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"800","resolutionHeight":"600","ip":"63.29.38.214"}'
    @payload_4 = 'payload={"url":"http://yahoo.com/not_news","requestedAt":"2013-01-14 21:38:28 -0700","respondedIn":123,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":["slow"],"eventName": "beginRegistration","userAgent":"Mozilla/3.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"800","resolutionHeight":"600","ip":"72.29.38.214"}'
    @payload_5 = 'payload={"url":"http://yahoo.com/not_news","requestedAt":"2015-01-14 21:38:28 -0700","respondedIn":130,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":["slow"],"eventName": "beginRegistration","userAgent":"Mozilla/3.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"800","resolutionHeight":"600","ip":"100.100.38.214"}'
    @payload_6 = 'payload={"url":"http://yahoo.com/chat_room","requestedAt":"2015-01-14 21:38:28 -0700","respondedIn":10,"referredBy":"http://jumpstartlab.com","requestType":"POST","parameters":["slow"],"eventName": "chatting","userAgent":"Mozilla/3.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Firefox/24.0.1309.0 Safari/537.17","resolutionWidth":"1000","resolutionHeight":"1000","ip":"88.88.88.888"}'
    post '/sources/yahoo/data', @payload_1
    post '/sources/yahoo/data', @payload_2
    post '/sources/yahoo/data', @payload_3
    post '/sources/yahoo/data', @payload_4
    post '/sources/yahoo/data', @payload_5
    post '/sources/yahoo/data', @payload_6
  end
end
