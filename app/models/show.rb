class Show < ApplicationRecord
  belongs_to :movie
  belongs_to :hall
  belongs_to :timing
end
