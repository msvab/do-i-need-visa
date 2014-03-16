class IndexController < ApplicationController

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
    country.downcase! unless country.nil?
  end

  def find_visa(form)
    if form[:citizen] == form[:country]
      Visa.new(form)
    else
      Visa.where(citizen: form[:citizen], country: form[:country]).take
    end
  end
end
