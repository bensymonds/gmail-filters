require 'builder'

module Property
  def fields(*fields)
    @@fields = fields
    fields.each do |field|
      define_method field do |value|
        instance_variable_set("@#{field}", value)
      end
    end
  end

  def to_xml
    out = ""
    builder = Builder::XmlMarkup.new(target: out)
    @@fields.each do |field|
      next if (v = instance_variable_get("@#{field}")).nil?
      builder.tag!("apps:property", name: field, value: v)
    end
    out
  end
end
