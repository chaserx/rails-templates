#include the base template
load_template "/Users/chasesouthard/RailsProjects/rails-templates/base_template.rb"

# handle CSV files
gem 'fastercsv'

# Authlogic
if yes?("Do you want to use AuthLogic?")
  plugin 'authlogic', :git => 'git://github.com/binarylogic/authlogic.git'
end

# file uploads with paperclip
if yes?("You you want to handle file uploads with Paperclip?")
  plugin 'paperclip', :git => 'git://github.com/thoughtbot/paperclip.git'
end

