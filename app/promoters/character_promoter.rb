class CharacterPromoter
 def initialize(character)
   @character = character
   @response = character[:data][:results][0]
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
     name: response[:name],
     description: response[:description],
     image: "#{response[:thumbnail][:path]}.#{response[:thumbnail][:extension]}"
   }
 end
 def as_series
   {
     title: response[:title],
     description: response[:description],
     story_count: response[:stories][:returned],
     image: "#{response[:thumbnail][:path]}.#{response[:thumbnail][:extension]}"
   }
 end
 private
 attr_reader :character, :response
end
