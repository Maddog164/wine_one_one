class Wine < ApplicationRecord
    belongs_to :user
    has_many :wine_tasting_notes
    has_many :tasting_notes, :through => :wine_tasting_notes
    has_many :pairings, inverse_of: :wine
    has_many :foods, :through => :pairings
    
    def foods_attributes=(attributes)
        attributes.values.each do |att|
            
            if !att[:food_name].blank?
                if !Food.find_by(food_name: att[:food_name])
                    food = Food.create(att)
                else
                    food = Food.find_by(food_name: att[:food_name])
                end
                self.foods << food
            end
        end 
    end

    def pairings_attributes=(attributes)
        
        pairing = Pairing.new(attributes["0"])
    end      
   
end
