# Load the Rails application.
require File.expand_path('../application', __FILE__)

ActiveSupport::Inflector.inflections do |inflect|
  inflect.plural 'senador', 'senadores'
end

# Initialize the Rails application.
SenadoCc::Application.initialize!
