class VisaSource < ActiveRecord::Base
  has_many :visas, dependent: :delete_all

  validates :name, :country, :url, :description, presence: true

  validates :name, :url, :etag, length: { maximum: 255 }
  validates :country, length: { is: 2 }

  validate :etag_or_date_presence

  private

  def etag_or_date_presence
    errors.add(:base, 'Etag or last modified date must be set.') if etag.blank? && last_modified.blank?
  end
end
