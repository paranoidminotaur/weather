RSpec.describe "OpenWeather", type: :service do
  subject { OpenWeather.new }
  describe "#get_forecast" do
    context "postal code is not provided" do
      it "raises an error" do
        expect {
          subject.get_forecast(
            street: "123 Main St",
            city: "Anytown",
            state: "NY",
            country: "US"
          )
        }.to raise_error('Invalid postal code')
      end
    end

    context "forecast cached" do
      context "forecast is less than 30 minutes old" do
        it "returns the cached forecast" do
          forecast = Forecast.create!(data: '{"weather": [{}], "main": {"description": ""}}', postal_code: "12345")
          expect(subject.get_forecast(postal_code: "12345")).to eq(forecast)
        end
      end

      context "forecast is more than 30 minutes old" do
        it "fetches a new forecast" do
          forecast = Forecast.create!(data: '{"weather": [{}], "main": {"description": ""}}', postal_code: "12345", created_at: 31.minutes.ago)
          allow(Geocoder).to receive(:search) { [double(coordinates: [0, 0])] }
          WebMock.stub_request(:get, /api.openweathermap.org/).to_return(body: '{"weather": [{}], "main": {"description": ""}}')
          expect(subject.get_forecast(postal_code: "12345").id).not_to eq(forecast.id)
        end
      end
    end

    context "forecast not cached" do
      it "fetches a new forecast" do
        allow(Geocoder).to receive(:search) { [double(coordinates: [0, 0])] }
        WebMock.stub_request(:get, /api.openweathermap.org/).to_return(body: '{"weather": [{}], "main": {"description": ""}}')
        expect(subject.get_forecast(postal_code: "12345")).to be_a(Forecast)
      end
    end
  end
end
