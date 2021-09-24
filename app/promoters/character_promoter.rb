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
   ext = response[:thumbnail][:extension]
   fname = response[:thumbnail][:path]
   {
     name: response[:name],
     description: response[:description],
     image: "#{response[:thumbnail][:path]}.#{response[:thumbnail][:extension]}",
     images: {
       standard: {
         small: "#{fname}/standard_small.#{ext}",
         medium: "#{fname}/standard_medium.#{ext}",
         large: "#{fname}/standard_xlarge.#{ext}",
         fantastic: "#{fname}/standard_fantastic.#{ext}",
         amazing: "#{fname}/standard_amazing.#{ext}"
       },
       portrait: {
         small: "#{fname}/portrait_small.#{ext}",
         medium: "#{fname}/portrait_medium.#{ext}",
         large: "#{fname}/portrait_xlarge.#{ext}",
         fantastic: "#{fname}/portrait_fantastic.#{ext}",
         uncanny: "#{fname}/portrait_uncanny.#{ext}",
         amazing: "#{fname}/portrait_amazing.#{ext}"
       },
       landscape: {
         small: "#{fname}/landscape_small.#{ext}",
         medium: "#{fname}/landscape_medium.#{ext}",
         large: "#{fname}/landscape_xlarge.#{ext}",
         amazing: "#{fname}/landscape_amazing.#{ext}",
         incredible: "#{fname}/landscape_incredible.#{ext}"
       }
     }
   }
 end
 def as_series
   character_series.map do |series|
     fname = series[:thumbnail][:path]
     ext = series[:thumbnail][:extension]
     {
       title: series[:title],
       description: series[:description],
       image: "#{fname}/standard_small.#{ext}",
       standard_images: {
         small: "#{fname}/standard_small.#{ext}",
         medium: "#{fname}/standard_medium.#{ext}",
         large: "#{fname}/standard_large.#{ext}",
         amazing: "#{fname}/standard_amazing.#{ext}"
       },
       portrait_images: {
         small: "#{fname}/portrait_small.#{ext}",
         medium: "#{fname}/portrait_medium.#{ext}",
         large: "#{fname}/portrait_xlarge.#{ext}",
         amazing: "#{fname}/portrait_amazing.#{ext}"
       },
       landscape_images: {
         small: "#{fname}/landscape_small.#{ext}",
         medium: "#{fname}/landscape_medium.#{ext}",
         large: "#{fname}/landscape_large.#{ext}",
         amazing: "#{fname}/landscape_amazing.#{ext}"
       }
     }
   end
 end
 private
 attr_reader :character, :response, :character_series
end
