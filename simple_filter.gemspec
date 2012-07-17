# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name        = 'simple_filter'
  s.version     = '0.0.1'
  s.date        = '2012-07-11'
  s.summary     = "Adds a simple filter and sort functionality for ActiveRecord models"
  s.description = "Adds a simple filter and sort functionality for ActiveRecord models"
  s.authors     = ["Jacek Jakubik"]
  s.email       = 'jakubik.jacek@gmail.com'
  s.files       = `git ls-files`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.homepage    = 'http://github.com/rindek/simple_filter'
  s.add_dependency 'activerecord', '>= 0'
end
