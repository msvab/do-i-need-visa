class Visa < ActiveRecord::Base
  validates :citizen, presence: true
  validates :citizen, length: { is: 2 }

  belongs_to :visa_source
end
