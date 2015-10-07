class CreateTransactions < ActiveRecord::Migration
  def self.up
    create_table "transactions" do |t|
      t.string :first_name, :last_name, :email
      t.text :raw
      t.timestamps
    end
  end

  def self.down
    drop_table "transactions"
  end
end
