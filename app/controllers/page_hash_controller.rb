require_relative '../../lib/tasks/page_hash'

class PageHashController < ApplicationController
  force_ssl if Rails.env.production?

  before_filter :require_login

  def calculate
    page_hash = PageHash.calculate(params[:url], params[:selector])
    render json: {page_hash: page_hash}
  end
end