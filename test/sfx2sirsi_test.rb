require "minitest/autorun"
require "nokogiri"
require_relative "../lib/sfx2sirsi.rb"

class TestSfx2Sirsi < Minitest::Test
  def setup
    output = File.open("data/output.txt").read.chomp
    @output = output.lines.map(&:chomp)
    @input = Nokogiri::XML(File.open("data/sfx_input.xml").read)
  end

  def test_sfx2sirsi
    assert_instance_of Array, @output
    output = []
    ids = []
    @input.xpath("//xmlns:record", :xmlns=>"http://www.loc.gov/MARC21/slim").each do |input|
      processed, id = Sfx2Sirsi.new(input).process
      output << processed
      ids << id
    end
    assert_equal output.first, @output.first
    assert_equal output.last, @output.last
    assert_equal ids.first, "55555"
    assert_equal ids.last, "55556"
  end

end
