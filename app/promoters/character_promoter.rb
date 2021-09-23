class CharacterPromoter
 def initialize(character)
   @character = character
   @response = character[:data][:results][0]
   @character_series = character[:data][:results]
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
     image: "#{response[:thumbnail][:path]}.#{response[:thumbnail][:extension]}",
     image_portrait: "#{response[:thumbnail][:path]}/portrait_xlarge.#{response[:thumbnail][:extension]}",
     image_standard: "#{response[:thumbnail][:path]}/standard_amazing.#{response[:thumbnail][:extension]}",
     image_landscape: "#{response[:thumbnail][:path]}/landscape_xlarge.#{response[:thumbnail][:extension]}"
   }
 end
 def as_series
   character_series.map do |series|
     {
       title: series[:title],
       description: series[:description],
       image: "#{series[:thumbnail][:path]}/standard_small.#{series[:thumbnail][:extension]}"
     }
   end
 end
 private
 attr_reader :character, :response, :character_series
end
