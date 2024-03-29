class Books::Leaves::MovesController < ApplicationController
  include BookScoped

  def create
    leaves.each.with_index(starting_position) do |leaf, position|
      leaf.move_to_position(position)
    end
  end

  private
    def starting_position
      params[:position].to_i
    end

    def leaves
      @book.leaves.find(Array(params[:id]))
    end
end
