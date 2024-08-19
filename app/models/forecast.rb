class Forecast < ApplicationRecord
  validates_presence_of :data, :postal_code
end
