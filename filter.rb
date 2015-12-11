class Filter
  attr_reader :match, :action

  def initialize
    @match = Match.new
    @action = Action.new
  end

  def to_xml
    out = ""
    builder = Builder::XmlMarkup.new(target: out)
    builder.category(term: "filter") {}
    matches.each do |m|
      builder << m.to_xml
    end
    out
  end

  def to_csv
    [
      match.to,
      match.hasTheWord,
      match.subject,
      match.from,
      nil,
      action.label,
      action.shouldArchive,
    ].to_csv(col_sep: "\t")
  end

  def to_s
    [
      "Filter: ",
      match,
      " THEN ",
      action,
      ">"
    ].join
  end
end
