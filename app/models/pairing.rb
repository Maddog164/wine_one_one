class Pairing < ApplicationRecord
    belongs_to :wine
    belongs_to :food

    accepts_nested_attributes_for :food
      
end
