class WineTastingNote < ApplicationRecord
    belongs_to :tasting_note
    belongs_to :wine
end
