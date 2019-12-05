class Hall < ApplicationRecord
  belongs_to :theatre
  validates :name, presence: true
  validates :seats, presence: true, :numericality => { :greater_than => 0}
end
