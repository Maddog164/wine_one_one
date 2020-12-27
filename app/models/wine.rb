class Wine < ApplicationRecord
    belongs_to :user
    has_many :wine_tasting_notes
    has_many :tasting_notes, :through => :wine_tasting_notes
    has_many :pairings
    has_many :foods, :through => :pairings
    accepts_nested_attributes_for :foods

end
