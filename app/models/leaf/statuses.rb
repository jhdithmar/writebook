module Leaf::Statuses
  extend ActiveSupport::Concern

  included do
    enum :status, %w[ draft published trashed ].index_by(&:itself), default: :draft

    default_scope { where.not(status: :trashed) }
  end
end
