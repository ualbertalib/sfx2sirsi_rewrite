require "nokogiri"
require_relative "./lib/sfx2sirsi.rb"
require_relative "./lib/hash_module.rb"

include HashModule

input = Nokogiri::XML(File.open("data/sfxdata.xml").read)
output = []
hashes = {}
previous_hashes = eval(File.open("data/hashes.txt").read)
input.xpath("//xmlns:record", :xmlns=>"http://www.loc.gov/MARC21/slim").each do |input|
  processed, id = Sfx2Sirsi.new(input).process
  hashes[id] = HashModule.create_hash(input)
  output << processed unless hashes[id] == previous_hashes[id]
  puts "sfx2sirsi: #{id}"
end
File.open("data/outfile.txt", "w"){ |of|
  output.each{ |o| of.puts o }
}

File.open("data/hashes.txt", "w"){ |of|
  of.write hashes
}
