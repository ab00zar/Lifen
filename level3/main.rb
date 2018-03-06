require "../worker.rb"
require "../shift.rb"
require "../reader.rb"
require "../writer.rb"
require "date"

class Main
  def initialize
    reader = Reader.new
    @workers = reader.data_hash['workers'].map { |w| Worker.new w['id'], w['first_name'], w['status'] }
    @shifts = reader.data_hash['shifts'].map {|sh| Shift.new sh['id'], sh['planning_id'], sh['user_id'], sh['start_date']}
    @results = []
    compute_salaries
    writer = Writer.new({"workers": @results})
  end

  def compute_salaries
    @workers.each do |w|
      number_of_weekend_shifts = @shifts.select {|sh| sh.user_id == w.id && [0,6].include?(Date.parse(sh.start_date).wday) }.size
      number_of_weekday_shifts = @shifts.select {|sh| sh.user_id == w.id && [1,2,3,4,5].include?(Date.parse(sh.start_date).wday) }.size

      w.salary_indicator == "medic" ? price = (270 * number_of_weekday_shifts + 2 * 270 * number_of_weekend_shifts) : price =
          (126 * number_of_weekday_shifts + 2 * 126 * number_of_weekend_shifts)
      @results.push({"id" => w.id, "price" => price})
    end
  end
end

Main.new
