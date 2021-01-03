class Pairing < ApplicationRecord
    belongs_to :wine
    belongs_to :food
    # accepts_nested_attributes_for :food

    def food_attributes=(attributes)
        food = Food.find_or_create_by(attributes)
        self.food_id = food.id
        binding.pry
    end
 
end
