class Wine < ApplicationRecord
    belongs_to :user
    has_many :wine_tasting_notes
    has_many :tasting_notes, :through => :wine_tasting_notes
    has_many :pairings, inverse_of: :wine
    has_many :foods, :through => :pairings
    accepts_nested_attributes_for :pairings, :allow_destroy => true
    accepts_nested_attributes_for :foods

    def foods_attributes=(foods_hashes)
        # Prevents multiples of same food being added to foods table
        foods_hashes.each do |i, food_attributes|
            if food_attributes[:food_name].present?
                food = Food.find_or_create_by(food_name: food_attributes[:food_name])
                if !self.foods.include?(food)
                    self.pairings.build(:food => food)
                end
            end
        end
    end
   
end
