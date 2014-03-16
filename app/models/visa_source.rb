class VisaSource < ActiveRecord::Base
  has_many :visas, dependent: :delete_all
end
