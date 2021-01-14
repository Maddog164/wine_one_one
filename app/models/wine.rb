class Wine < ApplicationRecord
    belongs_to :user
    has_many :wine_tasting_notes
    has_many :tasting_notes, :through => :wine_tasting_notes
    has_many :pairings, inverse_of: :wine
    has_many :foods, :through => :pairings
    accepts_nested_attributes_for :pairings, :allow_destroy => true
    accepts_nested_attributes_for :foods

    def foods_attributes=(attributes)
        binding.pry
        attributes.values.each do |att|
            if !att[:food_name].blank?
                food = Food.new(att)
                self.foods << food
                # @has_food = true #to use to assess for pairing
            end
            
        end 
    end

    def pairings_attributes=(attributes)
        binding.pry
        # attributes.values.each do |att|
        pairing = Pairing.new(attributes["0"])
        
        # self.pairings << pairing
        # pairing.pairing_type = 
        binding.pry
    end      
   
end
