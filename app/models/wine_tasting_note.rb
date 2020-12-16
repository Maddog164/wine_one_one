class WineTastingNote < ApplicationRecord
    belongs_to :tasting_notes
    belongs_to :wines
end
