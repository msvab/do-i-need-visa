class SearchForm
  attr_accessor :result, :searched
  attr_reader :citizen, :country

  def initialize(citizen, country)
    @citizen = citizen.upcase if citizen
    @country = country.upcase if country
  end
end