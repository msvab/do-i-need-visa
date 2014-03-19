# Load the Rails application.
require File.expand_path('../application', __FILE__)

# don't wrap invalid inputs in div
ActionView::Base.field_error_proc = Proc.new { |html_tag, instance|
  html_str = "#{html_tag}" +
      "<span class='glyphicon glyphicon-remove form-control-feedback'></span>" +
      "<span class='help-block'>#{instance.error_message.join(', ')}</span>"
  html_str.html_safe
}

# Initialize the Rails application.
DoINeedVisa::Application.initialize!
