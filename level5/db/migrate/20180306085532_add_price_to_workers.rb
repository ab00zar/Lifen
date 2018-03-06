class AddPriceToWorkers < ActiveRecord::Migration[5.1]
  def change
    add_column :workers, :price, :integer, default: 0
  end
end
