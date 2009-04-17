#include the base template
load_template "/Users/chasesouthard/RailsProjects/rails-templates/base_template.rb"

# Authlogic
if yes?("Do you want to use AuthLogic?")
  plugin 'authlogic', :git => 'git://github.com/binarylogic/authlogic.git'
end