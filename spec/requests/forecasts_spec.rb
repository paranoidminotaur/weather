require 'rails_helper'

RSpec.describe "Forecasts", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/forecasts"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    context "the forecast exists" do
      let(:forecast) { Forecast.create!(data: '{"weather": [{}], "main": {"description": ""}}', postal_code: "12345") }

      it "returns http success" do
        get "/forecasts/#{forecast.id}"
        expect(response).to have_http_status(:success)
      end
    end

    context "the forecast does not exist" do
      it "returns http not found" do
        get "/forecasts/1"
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "POST /create" do
    context "the forecast is successfully created" do
      let(:forecast) { Forecast.create!(data: '{"weather": [{}], "main": {"description": ""}}', postal_code: "12345") }

      it "redirects to the forecast page" do
        allow_any_instance_of(OpenWeather).to receive(:get_forecast).and_return(forecast)
        post "/forecasts", params: { street: "123 Main St", city: "Anytown", state: "NY", country: "US", postal_code: "12345" }
        expect(response).to redirect_to(forecast_path(forecast.id))
      end
    end

    context "the forecast is not successfully created" do
      it "redirects with an error message" do
        allow_any_instance_of(OpenWeather).to receive(:get_forecast).and_raise(StandardError.new("An error occurred"))
        post "/forecasts", params: { street: "123 Main St", city: "Anytown", state: "NY", country: "US", postal_code: "12345" }
        expect(response).to redirect_to(forecasts_path)
        expect(flash[:error]).to eq("An error occurred")
      end
    end
  end
end
