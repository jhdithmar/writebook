class QrCodeController < ApplicationController
  allow_unauthenticated_access

  before_action :set_qr_code_link

  def show
    expires_in 1.year, public: true
    render plain: svg_image, content_type: "image/svg+xml"
  end

  private
    def svg_image
      RQRCode::QRCode.new(@qr_code_link.url).as_svg(viewbox: true, fill: :white, color: :black)
    end

    def set_qr_code_link
      @qr_code_link = QrCodeLink.from_signed(params[:id])
      head :not_found unless @qr_code_link.present?
    end
end
