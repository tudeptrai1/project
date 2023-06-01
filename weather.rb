# frozen_string_literal: true

require 'faraday'

# Get Weather API
class Weather
  API_KEY = 'NrLzwpzp7aFhc0QGHJtuM83QS0bxypNO'
  API_URL = 'https://api.tomorrow.io/v4/weather/realtime'

  def initialize
    @conn = Faraday.new(API_URL)
    @api_key = API_KEY
  end

  def temperature(location)
    query_params = {
      location:,
      apikey: @api_key
    }
    response = @conn.get '', query_params
    JSON.parse(response.body)
  end

  def print_temp(location)
    result = temperature(location)
    str = "Địa điểm : #{result['location']['name']} \n"
    str << "Nhiệt độ hiện tại : #{result['data']['values']['temperature']} độ C \n"
    str << "Chỉ số UV : #{result['data']['values']['uvIndex']} \n"
    str << "Tốc độ gió : #{result['data']['values']['windSpeed']} \n"
  end
end

test = Weather.new
puts test.print_temp('New York')
