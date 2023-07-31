class CreateStockpiles < ActiveRecord::Migration[6.1]
  def change
    create_table :stockpiles do |t|
      t.string :name, null: false
      t.datetime :expiry_on
      t.datetime :notice_on
      t.timestamps
    end
  end
end
