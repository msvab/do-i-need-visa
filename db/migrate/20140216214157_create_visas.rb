class CreateVisas < ActiveRecord::Migration
  def up
    create_table :visas do |t|
      t.string :citizen, null: false, limit: 2
      t.string :country, null: false, limit: 2
      t.belongs_to :visa_sources, index: true

      t.timestamps
    end
  end

  def down
    drop_table :visas
  end
end
