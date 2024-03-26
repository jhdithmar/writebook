module Leaf::Editable
  extend ActiveSupport::Concern

  included do
    has_many :edits, dependent: :delete_all

    after_create :record_initial_edit
    after_update :record_moved_to_trash, if: :was_trashed?
  end

  def edit(leafable_params)
    transaction do
      new_leafable = leafable.dup.tap { |l| l.update!(leafable_params) }
      update!(leafable: new_leafable)
      edits.revision.create!(leafable: new_leafable)
    end
  end

  private
    def record_initial_edit
      edits.creation.create!(leafable: leafable)
    end

    def record_moved_to_trash
      edits.trash.create!(leafable: leafable)
    end

    def was_trashed?
      trashed? && previous_changes.include?(:status)
    end
end
