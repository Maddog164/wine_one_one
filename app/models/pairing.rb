class Pairing < ApplicationRecord
    belongs_to :wine
    belongs_to :food, optional: true

    
    # after_create{|pairing|
    # #updates the last pairing record with the last food id added to complete the join
    #     if pairing.food_id == nil
    #         pairing.food_id = Food.last.id
    #         pairing.save
    #     end
    # }
end
