class Book < ApplicationRecord
  has_many :leaves, dependent: :destroy

  scope :ordered, -> { order(:title) }

  def press(leafable)
    transaction do
      leafable.save!
      leaves.create! leafable: leafable
    end
  end
end
