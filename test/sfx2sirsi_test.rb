require "minitest/autorun"
require "nokogiri"
require_relative "../lib/sfx2sirsi.rb"

class TestSfx2Sirsi < Minitest::Test
  def setup
    @output = File.open("data/output.txt").read.chomp
    @input = Nokogiri::XML(File.open("data/sfx_input.xml").read)
  end

  def test_sfx2sirsi
    output = Sfx2Sirsi.new(@input).process
    assert_equal output, @output
  end

end
