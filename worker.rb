class Worker
  attr_reader(:id, :name, :salary_indicator)
  def initialize(id, first_name, salary)
    @id = id
    @name = first_name
    @salary_indicator = salary
  end
end