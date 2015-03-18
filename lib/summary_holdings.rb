class SummaryHoldings

  def self.parse(subscription_fields)
    years = []
    subscription_fields.each do |sub|
      sub.gsub(".","").split.each do |word|
        years << word.to_i if word =~ /\d\d\d\d/
      end
    end
    years.sort!
    "#{years.first}-#{years.last}"
  end

end
