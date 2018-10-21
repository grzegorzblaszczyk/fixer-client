module ReadConfigHelpers
  def get_api_key_from_config(filename)
    key_from_file = nil
    File.readlines(filename).each do |line|
      key_from_file = line.split("'")[1] if line.include?("api_key:")
    end
    key_from_file
  end
end