class CreateWines < ActiveRecord::Migration[6.0]
  def change
    create_table :wines do |t|
      t.string :wine_name
      t.string :color
      t.string :grape
      t.decimal :avg_price, :precision => 3, :scale => 2
      t.decimal :acidity, :precision => 3, :scale => 2
      t.integer :sweetness

      t.timestamps
    end
  end
end
