class CreateForecasts < ActiveRecord::Migration[7.0]
  def change
    create_table :forecasts do |t|
      t.string :zipcode
      t.datetime :sunrise
      t.datetime :sunset
      t.decimal :temp
      t.decimal :feels_like
      t.integer :pressure
      t.integer :humidity
      t.decimal :dew_point
      t.decimal :uvi
      t.integer :clouds
      t.integer :visibility
      t.decimal :wind_speed
      t.integer :wind_deg
      t.decimal :wind_gust
      t.string :main_descriptor
      t.string :description
      t.string :icon

      t.timestamps
    end
  end
end
