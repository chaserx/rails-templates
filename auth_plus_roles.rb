if yes?("Ready to remove default Rails files?")
  # Remove unnecessary Rails files
  run 'rm README'
  run 'rm public/index.html'
  run 'rm public/favicon.ico'
  run 'rm public/images/rails.png'
end

if yes?("Do you have a name for this app?")
  appname = ask("Spell it out for me:")
  run "echo #{appname} > README"
end

generate :nifty_layout

# Copy database.yml
run 'cp config/database.yml config/database.yml.example'

# Get auth and role plugins
plugin 'open_id_authentication', :git => 'git://github.com/rails/open_id_authentication.git'
plugin 'role_requirement', :git => 'git://github.com/timcharper/role_requirement.git'
plugin 'restful-authentication', :git => 'git://github.com/technoweenie/restful-authentication.git'

# state machine
gem 'rubyist-aasm', :source => 'http://gems.github.com'
plugin 'aasm', :git => 'git://github.com/rubyist/aasm.git'


# Some BDD/TDD Stuff
gem 'thoughtbot-shoulda', :lib => 'shoulda', :source => 'http://gems.github.com'
plugin 'rspec', :git => 'git://github.com/dchelimsky/rspec.git'
plugin 'rspec-rails', :git => 'git://github.com/dchelimsky/rspec-rails.git'

# Install gems on local system
rake('gems:install', :sudo => true) 

# Run some tasks and generators
rake('db:sessions:create')
generate("authenticated", "user session")
generate("roles", "Role User")
generate("rspec")
rake('open_id_authentication:db:create')
rake('db:migrate')

# Create .gitignore file
file '.gitignore', <<-FILE
.DS_Store
log/*.log
tmp/**/*
config/database.yml
db/*.sqlite3
FILE

run "touch tmp/.gitignore log/.gitignore vendor/.gitignore"

# Set up git repository
git :init
git :add => '.', :commit => "-m 'initial commit'"



# Some template actions created by You've Got Rails (http://www.youvegotrails.com)
# Thanks to ryanb for an excellent railscast on templating.