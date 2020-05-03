class CreateBookmarkUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :bookmark_users do |t|
      t.references :user, foreign_key: true
      t.references :bookmark, foreign_key: true

      t.timestamps
    end
  end
end
