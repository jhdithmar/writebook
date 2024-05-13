module Public
  class LeavesController < BaseController
    def show
      @book = Book.published.find_by! slug: params[:slug]
      @leaf = @book.leaves.find params[:leaf_id]
    end
  end
end
