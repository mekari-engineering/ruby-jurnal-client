module FixtureSupport
  def read_file_fixture(filename)   
    File.read('spec/fixtures/' + filename)
  end
end