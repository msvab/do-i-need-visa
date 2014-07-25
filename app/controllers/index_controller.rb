class IndexController < ApplicationController

  layout 'public'

  def index
    @visa = Visa.new(citizen: request_country(request.remote_ip))
  end

  def search
    @visa = find_visa(params[:visa])

    @searched = true
    render :index
  end

  private

  def request_country(ip)
    geo = GeoIP.new('vendor/assets/geoip/GeoIP.dat')
    country = geo.country(ip).country_code2
    country.upcase! unless country.nil?
    country
  end

  def find_visa(form)
    if form[:citizen] == form[:country]
      Visa.new(citizen: form[:citizen])
    else
      VisaSource.joins(:visas).where(country: form[:country], visas: {citizen: form[:citizen]}).first
    end
  end
end
