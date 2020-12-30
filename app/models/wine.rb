class Wine < ApplicationRecord
    belongs_to :user
    has_many :wine_tasting_notes
    has_many :tasting_notes, :through => :wine_tasting_notes
    has_many :pairings
    # accepts_nested_attributes_for :pairings, :allow_destroy => true

    has_many :foods, :through => :pairings
    # accepts_nested_attributes_for :pairings, :allow_destroy => true
    accepts_nested_attributes_for :foods, :allow_destroy => true

    # accepts_nested_attributes_for :pairings, :allow_destroy => true

    # attr_accessible :pairings_attributes
    

end
