class Shift < ApplicationRecord
    belongs_to :worker
    before_save :update_worker_price
    
    #update worker price (salary) while assigning a new shift to him/her
    def update_worker_price
        worker = Worker.find_by(id: worker_id)
        worker.update_attributes(price: worker.price + price_calculator(worker))
    end
    
    
    #calculating the worker price (salary) based on his/her status
    def price_calculator(w)
        case w.status
          when "medic"
            [0,6].include?(Date.parse(start_date).wday) ? 270 * 2 : 270
          when "interne"
            [0,6].include?(Date.parse(start_date).wday) ? 126 * 2 : 126
          when "interim"
            [0,6].include?(Date.parse(start_date).wday) ? 480 * 2 : 480
        end
    end
end
