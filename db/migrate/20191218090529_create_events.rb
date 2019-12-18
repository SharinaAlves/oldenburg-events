class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :name
      t.date :date
      t.time :time
      t.string :location
      t.text :description
      t.string :image
      t.string :link
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
