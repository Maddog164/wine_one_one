class Food < ApplicationRecord
    has_many :pairings, inverse_of: :food
    has_many :wines, :through => :pairings
   
    def get_pairing(wine_id, food_id)
        Pairing.find_by(wine_id: wine_id, food_id: food_id)
    end

end
