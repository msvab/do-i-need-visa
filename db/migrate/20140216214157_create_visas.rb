class CreateVisas < ActiveRecord::Migration
  def change
    create_table :visas do |t|
      t.string :citizen, null: false, limit: 2
      t.belongs_to :visa_source, index: true

      t.timestamps
    end
  end
end
