require "minitest/autorun"
require "nokogiri"
require_relative "../lib/hash_module.rb"

class TestChangedRecord < Minitest::Test

  def setup
    records = Nokogiri::XML(File.open("data/sfx_input.xml").read)
    @split_records =  records.xpath("//xmlns:record", :xmlns=>"http://www.loc.gov/MARC21/slim")
    @first_record = @split_records.first
    @second_record = @split_records.last
    @hashes = File.open("data/test_hashes.txt").read.lines.map(&:chomp)
  end

  def test_number_of_records
    assert_equal 2, @split_records.size
  end

  def test_hash_process
    first_record_hash = HashModule::create_hash(@first_record)
    assert_equal "08fe3fcc3a36dd0043cd9f4f982200eb8e47714f", first_record_hash
  end

  def test_equality
    is_the_same = HashModule::equal(@first_record, @first_record)
    assert is_the_same
    is_the_same = HashModule::equal(@first_record, @second_record)
    refute is_the_same
  end

  def test_changed
    changed_hash = @hashes.first
    unchanged_hash = @hashes.last
    refute HashModule.changed?(unchanged_hash, @first_record), "#{unchanged_hash}: #{HashModule::create_hash(@first_record)}"
    assert HashModule.changed?(changed_hash, @first_record)
  end

end
