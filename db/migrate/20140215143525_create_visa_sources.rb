class CreateVisaSources < ActiveRecord::Migration
  def change
    create_table :visa_sources do |t|
      t.string :name, null: false
      t.string :country, null: false, limit: 2
      t.string :url, null: false
      t.datetime :last_modified
      t.string :etag
      t.boolean :updated, null: false, default: false
      t.boolean :visa_required, null: false, default: true
      t.boolean :on_arrival, null: false, default: false
      t.text :description, null: false

      t.timestamps
    end
  end
end
