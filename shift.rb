class Shift
  attr_reader(:id, :planning_id, :user_id, :start_date)
  def initialize(id, planning_id, user_id, start_date)
    @id = id
    @planning_id = planning_id
    @user_id = user_id
    @start_date = start_date
  end
end