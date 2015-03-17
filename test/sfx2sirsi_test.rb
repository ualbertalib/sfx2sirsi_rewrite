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
    @input.xpath("//xmlns:record", :xmlns=>"http://www.loc.gov/MARC21/slim").each do |input|
      output << Sfx2Sirsi.new(input).process
    end
    assert_equal output.first, @output.first
    assert_equal output.last, @output.last
  end

end
