class CreateFamilies < ActiveRecord::Migration[6.1]
  def change
    create_table :families do |t|
      t.string :name, null: false
      t.integer :sex, null: false, default: 1
      t.integer :age, null: false
      t.integer :diet, null: false, default: 1
      t.boolean :pet, null: false, default: false
      t.timestamps
    end
  end
end
