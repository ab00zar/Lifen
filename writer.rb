require "json"
require "ostruct"

class Writer
  def initialize(content)
    write_to_file(content)
  end

  private

  def write_to_file(cnt)
    File.open('output.json', 'w') { |file| file.write(JSON.pretty_generate(cnt)) }
  end
end
