class Shift < ApplicationRecord
  belongs_to :worker
  before_save :update_worker_price
  after_destroy :decrease_worker_price

  #update worker price (salary) while assigning a new shift to him/her or updating a shift
  def update_worker_price
    if self.worker_id_changed?(from: nil)
      self.worker.update_attributes(price: self.worker.price + price_calculator(self.worker, start_date))
    else
      old_worker = Worker.find_by(id: worker_id_was)
      old_worker.update_attributes(price: old_worker.price - price_calculator(old_worker, start_date_was))
      self.worker.update_attributes(price: self.worker.price + price_calculator(self.worker, start_date))
    end

  end

  
  #decrease worker price (salary) while destroying a shift
  def decrease_worker_price
    self.worker.update_attributes(price: self.worker.price - price_calculator(self.worker, start_date))
  end


  #calculating the worker price (salary) based on his/her status
  def price_calculator(worker, date)
    case worker.status
      when "medic"
        [0,6].include?(Date.parse(date).wday) ? 270 * 2 : 270
      when "interne"
        [0,6].include?(Date.parse(date).wday) ? 126 * 2 : 126
      when "interim"
        [0,6].include?(Date.parse(date).wday) ? 480 * 2 : 480
    end
  end


end