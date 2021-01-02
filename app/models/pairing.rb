class Pairing < ApplicationRecord
    belongs_to :wine
    belongs_to :food

    def food_attributes=(attributes)
        food = Food.find_or_create_by(attributes)
        self.food_id = food.id
        binding.pry
    end
    
   
    # after_create{|pairing|
    # #updates the last pairing record with the last food id added to complete the join
    #     if pairing.food_id == nil
    #         pairing.food_id = Food.last.id
    #         pairing.save
    #     end
    # }
end
