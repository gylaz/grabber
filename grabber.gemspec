Gem::Specification.new do |s|
  s.name        = "grabber"
  s.version     = "0.0.0"
  s.date        = "2011-11-21"
  s.authors     = ["Greg Lazarev"]
  s.email       = "russianbandit@gmail.com"
  s.summary     = "Web site crawler and grabber"
  s.description = "Crawls the site and downloads assets to a specified directory"
  s.files       = ["lib/grabber.rb", "lib/grabber/site.rb", "lib/grabber/page.rb", "lib/grabber/util.rb"]
  s.executables << "grab"
  s.homepage    = ""

  s.add_dependency 'nokogiri'
end
