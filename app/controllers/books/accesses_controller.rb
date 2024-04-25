class Books::AccessesController < ApplicationController
  include BookScoped

  def index
    @accesses = User.active
  end
end
