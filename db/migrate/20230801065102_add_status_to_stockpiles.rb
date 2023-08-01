class AddStatusToStockpiles < ActiveRecord::Migration[6.1]
  def change
    add_column :stockpiles, :status, :boolean, default: false
  end
end
