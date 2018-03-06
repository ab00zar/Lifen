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
    @total_price = 0
    compute_salaries
    writer = Writer.new({"workers": @results, "commission" => {"pdg_fee" => compute_commission(@total_price),
                                                               "interim_shifts" => compute_number_of_interim_shifts}
                        })
  end

  def compute_salaries
    @total_price = 0
    @workers.each do |w|
      number_of_weekend_shifts = @shifts.select {|sh| sh.user_id == w.id && [0,6].include?(Date.parse(sh.start_date).wday) }.size
      number_of_weekday_shifts = @shifts.select {|sh| sh.user_id == w.id && [1,2,3,4,5].include?(Date.parse(sh.start_date).wday) }.size
      case w.salary_indicator
        when "medic"
          price = 270 * number_of_weekday_shifts + 2 * 270 * number_of_weekend_shifts
          @total_price += price
        when "interne"
          price = 126 * number_of_weekday_shifts + 2 * 126 * number_of_weekend_shifts
          @total_price += price
        when "interim"
          price = 480 * number_of_weekday_shifts + 2 * 480 * number_of_weekend_shifts
          @total_price += price
      end

      @results.push({"id" => w.id, "price" => price})
    end

  end

  def compute_commission(total)
    total * 0.05 + compute_number_of_interim_shifts * 80
  end

  def compute_number_of_interim_shifts
    number_of_interim_shifts = 0
    @workers.select {|w| w.salary_indicator == "interim"}.each do |interim|
      number_of_interim_shifts += @shifts.select {|sh| sh.user_id == interim.id}.size
    end
    number_of_interim_shifts
  end

end

Main.new
