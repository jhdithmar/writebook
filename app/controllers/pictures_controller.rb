class PicturesController < ApplicationController
  include SetBookLeaf

  def new
    @page = picture.new
  end

  def create
    @book.press new_picture
    redirect_to @book
  end

  def show
  end

  def edit
  end

  def update
    @leaf.update! leafable: new_picture
    redirect_to @book
  end

  def destroy
  end

  private
    def new_picture
      Picture.new params.require(:picture).permit(:title, :image).compact
    end
end
