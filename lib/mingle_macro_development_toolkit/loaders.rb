#Copyright 2012 ThoughtWorks, Inc.  All rights reserved.

Dir.glob(File.join(File.dirname(__FILE__), "loaders", "**/*.rb")).each do |file|
  require file
end