class Table < ApplicationRecord
  has_one :robot, dependent: :nullify

  validates :size_x,
            numericality: { greater_than_or_equal_to: 5, less_than_or_equal_to: 100 }
  validates :size_y,
            numericality: { greater_than_or_equal_to: 5, less_than_or_equal_to: 100 }
end
