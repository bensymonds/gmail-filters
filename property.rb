require 'builder'

module Property
  def fields(*fields)
    return @fields if fields.empty?
    @fields = fields.map(&:to_s)
    attr_accessor *fields
  end

  def initialize(attrs = {})
    attrs.each do |k, v|
      instance_variable_set("@#{k}", v)
    end
  end

  def to_xml
    out = ""
    builder = Builder::XmlMarkup.new(target: out)
    fields.each do |field|
      next if (v = instance_variable_get("@#{field}")).nil?
      builder.tag!("apps:property", name: field, value: v)
    end
    out
  end

  def to_csv
    self.class.fields.map do |f|
      send(f)
    end.compact.to_csv
  end

  def to_s
    [
      self.class.name,
      "(",
      self.class.fields.map do |f|
        next unless v = send(f)
        "#{f}:\"#{v}\""
      end.compact.join(" "),
      ")"
    ].join
  end
end
