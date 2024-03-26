class Leaf < ApplicationRecord
  include Editable, Positionable

  belongs_to :book

  delegated_type :leafable, types: Leafable::TYPES, dependent: :destroy
  delegate :title, to: :leafable

  positioned_within :book, association: :leaves

  scope :with_leafables, -> { includes(:leafable) }
end
