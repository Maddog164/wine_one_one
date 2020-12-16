class CreatePairings < ActiveRecord::Migration[6.0]
  def change
    create_table :pairings do |t|
      t.integer :wine_id
      t.integer :food_id
      t.string :pairing_type

      t.timestamps
    end
  end
end
