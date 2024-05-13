module PublicHelper
  def public_view?
    params[:controller].start_with? "public/"
  end
end
