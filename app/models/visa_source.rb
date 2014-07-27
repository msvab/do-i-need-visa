class VisaSource < ActiveRecord::Base
  has_many :visas, dependent: :destroy

  validates :name, :country, :url, :description, presence: true

  validates :name, :url, :etag, length: { maximum: 255 }
  validates :country, length: { is: 2 }

  validate :etag_or_date_presence

  def visa_codes
    visas.collect { |visa| visa.citizen }
  end

  def visa_codes=(codes)
    # delete all that are no longer in the codes collection
    visas.each { |visa|
      visas.destroy(visa) unless codes.include? visa.citizen
    }

    codes.each { |code|
      if visas.none? { |visa| visa.citizen == code }
        visas << Visa.new(citizen: code, visa_source: self)
      end
    }
    save!
  end

  def ==(comparison_object)
    attributes == comparison_object.attributes
  end

  private

  def etag_or_date_presence
    errors.add(:base, 'Etag or last modified date must be set.') if etag.blank? && last_modified.blank?
  end
end
