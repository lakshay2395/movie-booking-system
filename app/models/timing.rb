# frozen_string_literal: true

class Timing < ApplicationRecord
  validates :start_time, presence: true
  validates :end_time, presence: true
end
