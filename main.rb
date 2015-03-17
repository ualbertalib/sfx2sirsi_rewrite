require "nokogiri"
require_relative "./lib/sfx2sirsi.rb"
require_relative "./lib/hash_module.rb"

include HashModule

input = Nokogiri::XML(File.open("data/sfxdata.xml").read)
output = []
hashes = []
input.xpath("//xmlns:record", :xmlns=>"http://www.loc.gov/MARC21/slim").each do |input|
  puts "sfx2sirsi: ."
  output << Sfx2Sirsi.new(input).process
  hashes << HashModule.create_hash(input)
end
File.open("data/outfile.txt", "w"){ |of|
  output.each{ |o| of.puts o }
}

File.open("data/hashes.txt", "w"){ |of|
  hashes.each { |o| of.puts o }
}
