require "test_helper"

class QrCodeControllerTest < ActionDispatch::IntegrationTest
  test "show" do
    qr_code_link = QrCodeLink.new("https://example.com")

    get qr_code_url(qr_code_link.signed)

    assert_response :success
    assert_equal "image/svg+xml", response.media_type
    assert_match /<svg.*>.*<\/svg>/, response.body
  end

  test "show with invalid signed link" do
    get qr_code_url("invalid")

    assert_response :not_found
  end
end
