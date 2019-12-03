class Region < ApplicationRecord
    enum type: [:COUNTRY, :STATE, :CITY]
    belongs_to :parent, class_name: 'Region', optional: true
    has_many :children, class_name: 'Region', foreign_key: 'parent_id'
end