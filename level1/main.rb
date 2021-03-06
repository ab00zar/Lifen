require "../worker.rb"
require "../shift.rb"
require "../reader.rb"
require "../writer.rb"

class Main
  def initialize
    reader = Reader.new
    @workers = reader.data_hash['workers'].map { |w| Worker.new w['id'], w['first_name'], w['price_per_shift'] }
    @shifts = reader.data_hash['shifts'].map {|sh| Shift.new sh['id'], sh['planning_id'], sh['user_id'], sh['start_date']}
    @results = []
    compute_salaries
    writer = Writer.new({"workers": @results})
  end

  def compute_salaries

    @workers.each do |w|
       price = w.salary_indicator * @shifts.select {|sh| sh.user_id == w.id}.size
      @results.push({"id" => w.id, "price" => price})
    end
  end
end

Main.new
