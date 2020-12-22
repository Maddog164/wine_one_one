class Wine < ApplicationRecord
    belongs_to :user
    has_many :wine_tasting_notes
    has_many :tasting_notes, through: :wine_tasting_notes
    has_many :pairings
    has_many :foods, through: :pairings
    accepts_nested_attributes_for :foods

    # def wine_name=(name)
    #     self.wine= Wine.find_or_create_by(wine_name: name)
    # end

    # def wine_name
    #     self.wine ? self.wine.wine_name: nil
    # end

end
