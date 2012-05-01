if __FILE__ == $0
  require 'yaml'
  APP_CONFIG = YAML::load_file("#{Rails.root}/config/config.yml")[Rails.env]

end