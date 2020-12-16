class CreateFoods < ActiveRecord::Migration[6.0]
  def change
    create_table :foods do |t|
      t.string :food_name
      t.integer :food_sweetness
      t.decimal :food_acidity, :precision => 3, :scale => 2

      t.timestamps
    end
  end
end
