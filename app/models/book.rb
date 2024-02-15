class Book < ApplicationRecord
  has_many :leafs, dependent: :destroy

  scope :ordered, -> { order(:title) }
end
