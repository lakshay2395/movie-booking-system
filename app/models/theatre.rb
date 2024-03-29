# frozen_string_literal: true

class Theatre < ApplicationRecord
  belongs_to :region

  validates :name, presence: true
  validates :address, presence: true
end
