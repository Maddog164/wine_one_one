class CreateWineTastingNotes < ActiveRecord::Migration[6.0]
  def change
    create_table :wine_tasting_notes do |t|
      t.integer :wine_id
      t.integer :tasting_notes_id

      t.timestamps
    end
  end
end
