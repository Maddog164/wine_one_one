module FoodsHelper

    def change_pairing_type(id)
        binding.pry
        pairing = Pairing.find(id)
        if pairing.pairing_type == "Congruent"
            pairing.pairing_type = "Contrasting"
        else
            pairing.pairirng_type = "Congruent"
        end
        pairing.save
        binding.pry

    end
end
