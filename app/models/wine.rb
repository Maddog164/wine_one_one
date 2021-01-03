class Wine < ApplicationRecord
    belongs_to :user
    has_many :wine_tasting_notes
    has_many :tasting_notes, :through => :wine_tasting_notes
    has_many :pairings, inverse_of: :wine
    has_many :foods, :through => :pairings
    accepts_nested_attributes_for :pairings, :allow_destroy => true
    accepts_nested_attributes_for :foods

        def pairings_attributes=(attributes)
            attributes.values.each do |att|
                if !att[:food_id].blank? || !att[:food_attributes].blank?
                    pairing = Pairing.new(att)
                    pairing.wine = self
                    self.pairings << pairing
                end
            end
        end

        # def food_attributes=(attributes)
        #     food = Food.find_or_create_by(attributes)
        #     self.food_id = food.id
        #     binding.pry
        # end
                
   
end
