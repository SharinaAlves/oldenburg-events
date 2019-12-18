class CreateBookmarks < ActiveRecord::Migration[5.2]
  def change
    create_table :bookmarks do |t|
      t.user :reference
      t.event :reference

      t.timestamps
    end
  end
end
