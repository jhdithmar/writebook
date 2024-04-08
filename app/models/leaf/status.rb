module Leaf::Status
  extend ActiveSupport::Concern

  included do
    enum :status, %w[ draft published trashed ].index_by(&:itself), default: :draft

    default_scope { where.not(status: :trashed) }

    scope :including_trashed, -> { unscope(where: :status) }
  end
end
