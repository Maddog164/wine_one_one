class Wine < ApplicationRecord
    belongs_to :user
    has_many :wine_tasting_notes
    has_many :tasting_notes, :through => :wine_tasting_notes
    has_many :pairings, inverse_of: :wine
    has_many :foods, :through => :pairings, dependent: :destroy

    accepts_nested_attributes_for :pairings, :allow_destroy => true
    accepts_nested_attributes_for :foods

    validates :wine_name, presence: true
    validates :wine_name, uniqueness: {:scope=>:user_id}
    
    def food_attributes=(attributes)
        binding.pry
        attributes.values.each do |att|
            
            if !att[:food_name].blank?
                if !Food.find_by(food_name: att[:food_name])
                    food = Food.create(att)
                else
                    food = Food.find_by(food_name: att[:food_name])
                end
                self.foods << food
            else
                self.foods = []
            end
            
        end 
    end

    def food_exists?(food_name)
        !self.foods.where(food_name: food_name).blank?
    end

    def self.short_wines(wine_name)
        Wine.where("wine_name LIKE ?", "%#{wine_name}%")
    end
   
end
