require_relative 'triple'

Dir['tests/*[^spec].rb'].each {|file| require_relative file }
Dir['tests/*spec.rb'].each {|file| require_relative file }