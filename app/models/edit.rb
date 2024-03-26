class Edit < ApplicationRecord
  belongs_to :leaf
  delegated_type :leafable, types: Leafable::TYPES, dependent: :destroy

  enum :action, %w[ creation revision trash ].index_by(&:itself)
end
