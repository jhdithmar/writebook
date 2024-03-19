class PagesController < ApplicationController
  include SetBookLeaf

  def new
    @page = Page.new
  end

  def create
    @book.press new_page
    redirect_to @book
  end

  def show
  end

  def edit
  end

  def update
    @leaf.update! leafable: new_page
    redirect_to @book
  end

  def destroy
  end

  private
    def new_page
      Page.new params.require(:page).permit(:title, :body)
    end
end
