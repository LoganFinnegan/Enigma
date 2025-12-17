#!/usr/bin/env ruby
require 'date'
require_relative './enigma'

# Usage: ruby lib/decrypt.rb input.txt output.txt key DDMMYY
input_path, output_path, key, date = ARGV
unless input_path && output_path && key && date
  abort "Usage: ruby lib/decrypt.rb input.txt output.txt key DDMMYY"
end

ciphertext = File.read(input_path).chomp
enigma     = Enigma.new
result     = enigma.decrypt(ciphertext, key, date)

File.write(output_path, result[:decryption])
puts "Created '#{output_path}' with the key #{result[:key]} and date #{result[:date]}"
