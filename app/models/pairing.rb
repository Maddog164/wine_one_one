class Pairing < ApplicationRecord
    belongs_to :wine
    belongs_to :food, optional: true
end
