class ChangeVisaSource < ActiveRecord::Migration
  def change
    remove_columns :visa_sources, :etag, :last_modified
    add_column :visa_sources, :page_hash, :string, limit: 32
    add_column :visa_sources, :selector, :string, limit: 200
  end
end
