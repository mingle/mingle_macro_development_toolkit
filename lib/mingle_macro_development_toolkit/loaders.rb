#Copyright 2007 - 2013 ThoughtWorks, Inc.  All rights reserved.

Dir.glob(File.join(File.dirname(__FILE__), "loaders", "**/*.rb")).each do |file|
  require file
end
