class Food < ApplicationRecord
    has_many :pairings
    has_many :wines, :through => :pairings
    accepts_nested_attributes_for :pairings, :allow_destroy => true

end
