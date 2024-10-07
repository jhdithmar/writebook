class JumpsController < ApplicationController
  allow_unauthenticated_access
  before_action :set_book
  before_action :ensure_editable_book, only: :create

  def show
    if page = @book.pages.find_by(slug: params[:page_slug])
      redirect_to page
    elsif @book.editable?
      render # create new page via autosubmitting form
    else
      # FIXME: Convert to render a 404
      raise ActiveRecord::NotFound
    end
  end

  def create
    new_page = @book.pages.create! title: new_page_title_from(params[:page_slug])
    redirect_to new_page
  end

  private
    def set_book
      @book = Book.accessable_or_published.find_by!(slug: params[:book_slug])
    end

    def ensure_editable_book
      # FIXME: Convert to render a 403
      raise ActiveRecord::NotFound unless @book.editable?
    end

    def new_page_title_from(slug)
      slug.replace("-", " ").capitalize
    end
end
