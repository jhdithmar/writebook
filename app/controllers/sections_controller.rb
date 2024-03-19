class SectionsController < ApplicationController
  include SetBookLeaf

  def new
    @page = Section.new
  end

  def create
    @book.press new_section
    redirect_to @book
  end

  def show
  end

  def edit
  end

  def update
    @leaf.update! leafable: new_section
    redirect_to @book
  end

  def destroy
  end

  private
    def new_section
      Section.new params.require(:section).permit(:title)
    end
end
