class Then
  include Property
  FIELDS = [:label, :should_archive]
  attr_reader *FIELDS
end
