#!/usr/bin/env ruby
require 'date'
require_relative './enigma'

# Usage: ruby lib/encrypt.rb input.txt output.txt [key] [DDMMYY]
input_path, output_path, key, date = ARGV
unless input_path && output_path
  abort "Usage: ruby lib/encrypt.rb input.txt output.txt [key] [DDMMYY]"
end

message = File.read(input_path).chomp
enigma  = Enigma.new
result  = enigma.encrypt(message, key, date)

File.write(output_path, result[:encryption])
puts "Created '#{output_path}' with the key #{result[:key]} and date #{result[:date]}"
