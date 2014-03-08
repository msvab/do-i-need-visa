class Visa < ActiveRecord::Base
  validates :citizen, presence: true
  validates :country, presence: true

  belongs_to :visa_source
end
