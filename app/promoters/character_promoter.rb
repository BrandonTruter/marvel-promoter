class CharacterPromoter
 def initialize(character)
   @character = character
   @response = character[:data][:results][0]
 end
 def as_hero
   {
     id: response[:id],
     name: response[:name],
     thumbnail: response[:thumbnail],
     description: response[:description],
     attribute: character[:attributionText]
   }
 end
 private
 attr_reader :character, :response
end
