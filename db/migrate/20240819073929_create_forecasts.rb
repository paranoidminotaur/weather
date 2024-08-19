class CreateForecasts < ActiveRecord::Migration[7.0]
  def change
    create_table :forecasts do |t|
      t.string :postal_code, null: false
      t.string :data, null: false

      t.timestamps
    end
  end
end
