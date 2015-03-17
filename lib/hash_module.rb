require 'digest/sha1'

module HashModule

  def self.create_hash(record)
    Digest::SHA1::hexdigest(record.to_s)
  end

  def self.equal(first, second)
    create_hash(first) == create_hash(second)
  end

  def self.changed?(hash, record)
    hash == create_hash(record)
  end
end
