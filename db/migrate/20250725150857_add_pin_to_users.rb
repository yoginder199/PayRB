class AddPinToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :pin, :string
  end
end
