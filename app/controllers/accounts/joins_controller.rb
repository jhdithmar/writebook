class Accounts::JoinsController < ApplicationController
  def show
    @books = Current.user.books.editable
    @editable = get_selected_or_default(:editable_ids, Current.user.books.editable.ids)
    @readable = get_selected_or_default(:readable_ids)
    @readable = @books.map &:id
    @join_code = JoinCode.new(@editable, @readable)
  end

  private
    def get_selected_or_default(key)
      if params[key].present?
        Current.user.books.
        params[key]

      params[key] || []
    end
end
