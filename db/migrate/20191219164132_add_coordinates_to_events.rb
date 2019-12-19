class AddCoordinatesToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :lat, :float
    add_column :events, :lon, :float
  end
end
