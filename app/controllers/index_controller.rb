require 'ostruct'

class IndexController < ApplicationController

  layout 'public'

  def index
    @search_form = OpenStruct.new({ citizen: request_country(request.remote_ip), country: nil })
  end

  def search
    @search_form = OpenStruct.new(params[:search_form])
    @search_form[:searched] = true
    @search_form[:result] = find_visa_source(@search_form)

    render :index
  end

  private

  def request_country(ip)
    geo = GeoIP.new('vendor/assets/geoip/GeoIP.dat')
    country = geo.country(ip).country_code2
    country.upcase! unless country.nil?
    country
  end

  def find_visa_source(form)
    VisaSource.joins(:visas).where(country: form[:country], visas: {citizen: form[:citizen]}).first
  end
end
