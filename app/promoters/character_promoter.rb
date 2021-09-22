class CharacterPromoter
 def initialize(character)
   @character = character
   @iron_man = character[:data][:results][0]
 end
 def as_marvel
   {
     etag: character[:etag],
     copyright: character[:copyright],
     attribute: character[:attributionText]
   }
 end
 def as_hero
   {
     name: iron_man[:name],
     description: iron_man[:description],
     image: "#{iron_man[:thumbnail][:path]}.#{iron_man[:thumbnail][:extension]}"
   }
 end
 private
 attr_reader :character, :iron_man
end
