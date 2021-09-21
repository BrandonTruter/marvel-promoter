MarvelPromoter::Application.config.MARVEL_CONFIG = YAML.load_file("#{Rails.root}/config/marvel.yml")

sflog = Logger.new("#{Rails.root}/log/#{Rails.env}_marvel.log")
sflog.formatter = proc do |severity, datetime, progname, msg|
  "#{datetime.strftime('%Y/%m/%d %H:%M:%S')}, #{Socket.gethostname}, #{severity}, #{msg}\n"
end

::MARVEL = sflog
