dir = "sdoc"
rails_version = "v3.1.0"
ruby_version = ""

unless File.directory? "doc/rails/#{rails_version}"
  if File.directory? "../rails"
    p "updating rails repo..."
    Dir.chdir("../rails") do
      `git fetch origin`
    end
  else
    p "cloning rails..."
    `git clone https://github.com/rails/rails.git ../rails`
  end
  
  p "checking out rails #{rails_version}..."
  Dir.chdir("../rails") do
    `git checkout #{rails_version}`
  end

  p "creating sdocs of rails..."
  `sdoc -x test -o doc/rails/#{rails_version} ../rails`
end

unless File.directory? "doc/ruby/#{ruby_version}"
  if File.directory? "../ruby"
    p "updating ruby repo..."
    Dir.chdir("../ruby") do
      `git fetch origin`
    end
  else
    p "cloning ruby..."
    `git clone https://github.com/ruby/ruby.git ../ruby`
  end
  
  p "checking out ruby #{ruby_version}..."
  Dir.chdir("../ruby") do
    `git checkout #{ruby_version}`
  end

  p "creating sdocs of ruby..."
  `sdoc -x test -o doc/ruby/#{ruby_version} ../ruby`
end

p "creating sdocs of app..."
`rm -rf doc/cardgnome-app`
`sdoc -o doc/cardgnome-app app`

p "creating sdocs of lib..."
`rm -rf doc/cardgnome-lib`
`sdoc -o doc/cardgnome-lib lib`

p "cleaning out old sdocs..."
`rm -rf doc/merged`

p "merging sdocs..."
`sdoc-merge -o doc/merged -t "Card Gnome docs" -n "Ruby,Rails,Card Gnome application,Card Gnome libraries" doc/ruby doc/rails doc/cardgnome-app doc/cardgnome-lib`