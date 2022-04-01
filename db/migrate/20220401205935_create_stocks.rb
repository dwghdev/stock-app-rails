class CreateStocks < ActiveRecord::Migration[7.0]
  def change
    create_table :stocks do |t|
      t.string :company_name
      t.decimal :price, precision: 8, scale: 2

      t.timestamps
    end
  end
end