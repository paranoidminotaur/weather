class OpenWeather
  include HTTParty
  base_uri 'https://api.openweathermap.org/data/2.5/weather'

  def get_forecast(address = {})
    raise 'Invalid postal code' unless address[:postal_code].present?

    cached = Forecast.find_by(postal_code: address[:postal_code])
    return cached if cached && cached.created_at > 30.minutes.ago
    cached&.destroy

    geocoded = Geocoder.search(address.values.compact.join(','))
    lat, lon = geocoded.first.coordinates
    response = self.class.get("?lat=#{lat}&lon=#{lon}&appid=#{Rails.application.credentials.open_weather_key}&units=imperial")

    Forecast.create!(postal_code: address[:postal_code], data: response.to_s)
  end
end
