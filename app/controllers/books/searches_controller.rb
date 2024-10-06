class Books::SearchesController < ApplicationController
  include BookScoped

  def create
    @pages = if query.present?
      book_pages.search_in(query).limit(50)
    else
      Page.none
    end
  end

  private
    def query
      params[:search]&.gsub(/[^[:word:]]/, ' ')
    end

    def book_pages
      Page.joins(:leaf).where(leaves: { book: @book }).merge(Leaf.positioned)
    end
end
