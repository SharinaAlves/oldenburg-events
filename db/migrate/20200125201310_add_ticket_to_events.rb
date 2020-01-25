class AddTicketToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :ticket, :string
  end
end
