class CreateServices < ActiveRecord::Migration[5.1]
  def change
    create_table :services do |t|
      t.string :name, null: false
      t.integer :price_cents, null: false

      t.timestamps
    end
  end
end
