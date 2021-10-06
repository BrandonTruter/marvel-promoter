module ApplicationHelper

  def image_variants_helper(thumbnail, ratio, size)
    unless thumbnail.nil?
      extension = thumbnail[:extension]
      path = thumbnail[:path]
      case ratio
      when "landscape"
        display_landscape_images(size, path, extension)
      when "portrait"
        display_portrait_images(size, path, extension)
      else
        display_standard_images(size, path, extension)
      end
    end
  end

  def display_standard_images(size, fname, ext)
    case size
    when "small"
      "#{fname}/standard_small.#{ext}"
    when "medium"
      "#{fname}/standard_medium.#{ext}"
    when "large"
      "#{fname}/standard_xlarge.#{ext}"
    when "amazing"
      "#{fname}/standard_amazing.#{ext}"
    when "fantastic"
      "#{fname}/standard_fantastic.#{ext}"
    else
      "#{fname}.#{ext}"
    end
  end

  def display_landscape_images(size, fname, ext)
    case size
    when "small"
      "#{fname}/landscape_small.#{ext}"
    when "medium"
      "#{fname}/landscape_medium.#{ext}"
    when "large"
      "#{fname}/landscape_xlarge.#{ext}"
    when "amazing"
      "#{fname}/landscape_amazing.#{ext}"
    when "incredible"
      "#{fname}/landscape_incredible.#{ext}"
    else
      "#{fname}.#{ext}"
    end
  end

  def display_portrait_images(size, fname, ext)
    case size
    when "small"
      "#{fname}/portrait_small.#{ext}"
    when "medium"
      "#{fname}/portrait_medium.#{ext}"
    when "large"
      "#{fname}/portrait_xlarge.#{ext}"
    when "amazing"
      "#{fname}/portrait_fantastic.#{ext}"
    when "uncanny"
      "#{fname}/portrait_uncanny.#{ext}"
    when "amazing"
      "#{fname}/portrait_amazing.#{ext}"
    else
      "#{fname}.#{ext}"
    end
  end

end
