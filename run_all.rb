require_relative 'triple'

Dir['tests/*[^s][^p][^e][^c].rb'].each {|file| require_relative file }
Dir['tests/*spec.rb'].each {|file| require_relative file }