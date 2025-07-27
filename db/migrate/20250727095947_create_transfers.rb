class CreateTransfers < ActiveRecord::Migration[8.0]
  def change
    create_table :transfers do |t|
      t.integer :sender_id
      t.integer :recipient_id
      t.decimal :amount

      t.timestamps
    end
  end
end
