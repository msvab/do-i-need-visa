class ApplicationController < ActionController::Base
  include Clearance::Controller

  layout 'admin'

  protect_from_forgery with: :exception
end
