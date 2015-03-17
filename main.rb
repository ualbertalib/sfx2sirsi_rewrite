require "nokogiri"
require_relative "./lib/sfx2sirsi.rb"

input = Nokogiri::XML(File.open("data/sfxdata.xml").read)
output = []
input.xpath("//xmlns:record", :xmlns=>"http://www.loc.gov/MARC21/slim").each do |input|
  puts "."
  output << Sfx2Sirsi.new(input).process
end
File.open("data/outfile.txt", "w"){ |of|
  output.each{ |o| of.puts o }
}
