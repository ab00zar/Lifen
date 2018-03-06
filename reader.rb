require "json"
require "ostruct"

class Reader
  attr_reader(:data_hash)
  def initialize
    @data_hash = JSON.parse(File.read('data.json'))
  end
end