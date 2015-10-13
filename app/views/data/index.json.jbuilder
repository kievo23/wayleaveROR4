json.array!(@data) do |datum|
  json.extract! datum, :id, :permit_no, :route, :carriageway, :footpath, :verge, :amount_paid, :date_paid, :Remarks, :permit, :wayleave_file
  json.url datum_url(datum, format: :json)
end
