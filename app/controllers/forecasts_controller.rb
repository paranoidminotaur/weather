class ForecastsController < ApplicationController
  def index
  end

  def create
    begin
      @forecast = OpenWeather.new.get_forecast(
        street: params[:street],
        city: params[:city],
        state: params[:state],
        country: params[:country],
        postal_code: params[:postal_code]
      )
    rescue => e
      flash[:error] = e.message
      return redirect_to forecasts_path
    end

    redirect_to forecast_path(@forecast)
  end

  def show
    begin
      forecast = Forecast.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      return head :not_found
    end

    data = JSON.parse(forecast.data)
    @forecast = data['main'].merge(
      data['weather'].first
    ).merge(
      'postal_code' => forecast.postal_code,
      'last_updated' => ((Time.now - forecast.created_at)/60).to_i
    )
  end
end
