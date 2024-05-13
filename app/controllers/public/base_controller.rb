module Public
  class BaseController < ApplicationController
    skip_before_action :require_authentication
  end
end
