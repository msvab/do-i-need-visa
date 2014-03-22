class VisaSource < ActiveRecord::Base
  has_many :visas, dependent: :delete_all

  validates :name, :country, :url, :description, presence: true

  validates :name, :url, :etag, length: { maximum: 255 }
  validates :country, length: { is: 2 }

  validate :etag_or_date_presence

  def visa_codes
    visas.collect { |visa| visa.citizen }
  end

  def visa_codes=(codes)
    visas.where.not(citizen: codes).delete_all
    codes_to_create = codes.select {|code|
      found_visas = visas.select {|visa| visa.citizen == code}
      found_visas.empty?
    }
    codes_to_create.each { |code|
      visas << Visa.new(citizen: code, visa_source: self)
    }
    save
  end

  private

  def etag_or_date_presence
    errors.add(:base, 'Etag or last modified date must be set.') if etag.blank? && last_modified.blank?
  end
end
