require_relative "./summary_holdings.rb"

class Sfx2Sirsi

  def initialize(input_xml)
    @input_xml = input_xml
  end

  def process
    return open_url, sfx_object_id
  end

  def sfx_object_id
    field("090", "a")
  end

  def print_issn
    field("022", "a")
  end

  def electronic_issn
    field("776", "x")
  end

  def summary_holdings
    SummaryHoldings.parse(subscription_fields)
  end

  private

  def field(field, subfield)
    @input_xml.xpath("./xmlns:datafield[@tag='#{field}']/xmlns:subfield[@code='#{subfield}']", :xmlns=>"http://www.loc.gov/MARC21/slim").text
  end

  def subscription_fields
    fields = []
    @input_xml.xpath("./xmlns:datafield[@tag='866']", :xmlns=>"http://www.loc.gov/MARC21/slim").each do |subscription|
      fields << subscription.xpath("./xmlns:subfield[@code='a']", :xmlns=>"http://www.loc.gov/MARC21/slim").text
    end
    fields
  end
  
  def open_url
    "#{sfx_object_id}|#{print_issn}|#{electronic_issn}|http://resolver.library.ualberta.ca/resolver?ctx_enc=info%3Aofi%2Fenc%3AUTF-8&ctx_ver=Z39.88-2004&rfr_id=info%3Asid%2Fualberta.ca%3Aopac&rft.genre=journal&rft.object_id=#{sfx_object_id}&rft_val_fmt=info%3Aofi%2Ffmt%3Akev%3Amtx%3Ajournal&url_ctx_fmt=info%3Aofi%2Ffmt%3Akev%3Amtx%3Actx&url_ver=Z39.88-2004|#{summary_holdings}|false|restricted"
  end
end
