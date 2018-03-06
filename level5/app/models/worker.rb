class Worker < ApplicationRecord
    has_many :shifts
    
    #calculate total price (salary) of all workers
    def self.total
        total = 0
        Worker.all.each do |w|
            total += w.price
        end
        total
    end
    
    
    #calculate commission based on level4 rules
    def self.compute_commission
        @cc = total * 0.05 + compute_number_of_interim_shifts * 80
    end
    
    
    #count number of interim shifts
    def self.compute_number_of_interim_shifts
        number_of_interim_shifts = 0
        Worker.all.select {|w| w.status == "interim"}.each do |interim|
            number_of_interim_shifts += Shift.all.select {|sh| sh.worker_id == interim.id}.size
        end
        number_of_interim_shifts
    end
    
end
