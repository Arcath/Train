require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('trainbbcodeeditor','0.0.1') do |p|
	p.description 	= "Provides a nice looking editor for TrainBBCode"
	p.url		= "http://www.arcath.net/pages/4"
	p.author	= "Adam \"Arcath\" Laycock"
	p.email		= "gems@arcath.net"
	p.ignore_pattern= ["tmp/*", "script/*"]
	p.development_dependencies = []
	p.runtime_dependencies = ["trainbbcode"]
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }
