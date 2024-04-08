class Leaf < ApplicationRecord
  include Editable, Positionable

  belongs_to :book

  delegated_type :leafable, types: Leafable::TYPES, dependent: :destroy
  delegate :title, to: :leafable

  enum :status, %w[ draft published trashed ].index_by(&:itself), default: :draft

  positioned_within :book, association: :leaves

  default_scope { excluding_trashed }

  scope :with_leafables, -> { includes(:leafable) }
  scope :excluding_trashed, -> { where.not(status: :trashed) }
end
