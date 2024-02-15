class Leaf < ApplicationRecord
  belongs_to :book
  belongs_to :parent, class_name: "Leaf", required: false

  delegated_type :leafable, types: Leafable::TYPES, dependent: :destroy
  delegate :title, to: :leafable

  scope :roots, -> { where(parent: nil) }
  scope :with_leafables, -> { includes(:leafable) }
end
