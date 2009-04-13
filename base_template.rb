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

# Some BDD/TDD Stuff
gem 'thoughtbot-shoulda', :lib => 'shoulda', :source => 'http://gems.github.com'
plugin 'rspec', :git => 'git://github.com/dchelimsky/rspec.git'
plugin 'rspec-rails', :git => 'git://github.com/dchelimsky/rspec-rails.git'

# Install gems on local system
rake('gems:install', :sudo => true) if yes?('Install gems on local system? (y/n)')

# Run rspec generator
generate("rspec")


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