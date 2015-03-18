require "nokogiri"
require_relative "./lib/sfx2sirsi.rb"
require_relative "./lib/hash_module.rb"

include HashModule

desc "Setup data structures."
task :setup do
  @input = Nokogiri::XML(File.open("data/sfxdata.xml").read)
  @output = []
  @hashes = {}
  @previous_hashes = {}
  @previous_hashes = eval(File.open("data/hashes.txt").read) if File.exists? "data/hashes.txt"
end

desc "Run incremental update."
task :partial_update => :setup do
  update
  write_data
  write_hashes
end

desc "Run full update."
task :full_update => :setup do
  File.delete("data/hashes.txt")
  Rake::Task["partial_update"].execute
end

def update
  @input.xpath("//xmlns:record", :xmlns=>"http://www.loc.gov/MARC21/slim").each do |input|
    openurl, id = Sfx2Sirsi.new(input).process
    @hashes[id] = HashModule.create_hash(input)
    @output << openurl unless @hashes[id] == @previous_hashes[id]
  end
end

def write_data
  File.open("data/outfile.txt", "w"){ |of|
    output.each{ |o| of.puts o }
  }
end

def write_hashes
  File.open("data/hashes.txt", "w"){ |of|
    of.write hashes
  }
end

