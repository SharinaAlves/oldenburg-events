class CreateBookmarkEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :bookmark_events do |t|
      t.references :event, foreign_key: true
      t.references :bookmark, foreign_key: true

      t.timestamps
    end
  end
end
