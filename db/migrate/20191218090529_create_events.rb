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
      t.category :reference

      t.timestamps
    end
  end
end
