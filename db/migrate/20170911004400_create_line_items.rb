class CreateLineItems < ActiveRecord::Migration[5.1]
  def change
    create_table :line_items do |t|
      t.references :invoice, foreign_key: true, null: false
      t.references :product, foreign_key: true
      t.references :service, foreign_key: true
      t.integer :price_override_cents
      t.integer :quantity, null: false, default: 1
      t.string :description

      t.timestamps
    end
  end
end
