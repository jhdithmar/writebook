module Leaf::Editable
  extend ActiveSupport::Concern

  def edit(leafable_params)
    transaction do
      new_leafable = leafable.dup.tap { |l| l.update!(leafable_params) }
      update!(leafable: new_leafable)
    end
  end
end
