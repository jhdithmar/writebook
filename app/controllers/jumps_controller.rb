class JumpsController < ApplicationController
  allow_unauthenticated_access
  before_action :set_book
  before_action :ensure_editable_book, only: :create

  def show
    if leaf = @book.leaves.active.find_by(slug: params[:page_slug])
      redirect_to leaf
    elsif @book.editable?
      post_redirect_to posts_url
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


    def post_redirect_to(url)
      render html: %(<html><body><form id="redirect_form" action="#{url}"></form><script>document.getElementById("redirect").requestSubmit()</script></body></html>)
    end
end
