class Food < ApplicationRecord
    has_many :pairings, inverse_of: :food
    has_many :wines, :through => :pairings
    accepts_nested_attributes_for :pairings, :allow_destroy => true
    accepts_nested_attributes_for :wines

end
