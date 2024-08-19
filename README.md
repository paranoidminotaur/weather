# Weather App

This is a simple weather app that uses the OpenWeatherMap API to get the weather data for a given location.
It uses geocoder to get the latitude and longitude of the location and then uses the OpenWeatherMap API to get the weather data.

## Installation & Usage

- clone the repository
- cd into the directory
- `bundle install`
- `rails db:create db:migrate`
- `rails credentials:edit --environment=development` and add the following lines:
```yaml
open_weather_key: YOUR_OPEN_WEATHER_API_KEY
geocoding_key: YOUR_GEOAPIFY_KEY
```
To get an OpenWeatherMap API key, go to [OpenWeatherMap](https://home.openweathermap.org/users/sign_up) and sign up for an account. You will get an API key in your account settings.
To get a Geoapify API key, go to [Geoapify](https://www.geoapify.com/) and sign up for an account. You will get an API key in your account settings.
- `rspec spec` to run the tests
- `rails s` to start the server
- navigate to `localhost:3000` in your browser
- enter the location you want to get the weather data for
- submit the form

## Design Choices

### Modeling, Persistence, and Caching
I opted to create a very simple schema for my forecasts with only `postal_code` and `data` columns. I chose to store the data as a JSON object in the `data` column because the data returned from the OpenWeatherMap API is a JSON object and I wanted to store it as is. I could have created a separate table for the weather data and associated it with the forecast model, but I chose to keep it simple for this project. `postal_code` serves as a means for caching the weather data for a given location.

I chose to use sqlite as it requires no additional setup. Depending on the requirements of the production environment, I would likely choose Postgres or some other database with a native JSON column type.

Caching is relatively crude and verbose, but easy to understand. In a production environment, I would likely handle caching with redis, using expiring keys to handle the expiration of the cached entries, rather than using a coded solution.

### Frontend
I went with a very basic approach to the front end, using erb templates and a simple form to submit the location. Traditionally, if a more complex front end was required, I would use a component-based frontend framework like React or Vue, but for this project, I wanted to keep it simple. Rails-native stimulus/turbo could also be used to add some interactivity to the form.

