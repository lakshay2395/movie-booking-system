# frozen_string_literal: true

class Movie < ApplicationRecord
  validates :name, presence: true
  validates :director_name, presence: true
  validates :release_date, presence: true
  validates :is_active, inclusion: [true, false]
end
