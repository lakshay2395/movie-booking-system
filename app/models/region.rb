# frozen_string_literal: true

class Region < ApplicationRecord
  validates :name, presence: true
  enum region_type: %i[COUNTRY STATE CITY]
  validates :region_type, inclusion: { in: region_types.keys }
  belongs_to :parent, class_name: 'Region', optional: true
  has_many :children, class_name: 'Region', foreign_key: 'parent_id'
end
