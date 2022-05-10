class CreateInvoices < ActiveRecord::Migration[5.1]
  def change
    create_table :invoices do |t|
      t.references :client, foreign_key: true, null: false
      t.integer :net_days, null: false, default: 30
      t.string :note, null: true

      t.timestamps
    end
  end
end
