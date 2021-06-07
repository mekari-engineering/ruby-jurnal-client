module FixtureSupport
  def fixture_file_path(filename)
    "spec/fixtures/#{filename}"
  end

  def read_file_fixture(filename)
    data = File.read fixture_file_path(filename)

    case filename
    when ->(name) { name.include?('.xlsx') }
      Roo::Excelx.new(fixture_file_path(filename))
    when ->(name) { name.include?('.json') }
      JSON.parse(data)
    else
      data
    end
  end
end
