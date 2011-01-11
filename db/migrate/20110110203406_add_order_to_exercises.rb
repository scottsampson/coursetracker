class AddOrderToExercises < ActiveRecord::Migration
  def self.up
    execute "alter table exercises add order_num int(4)"
  end

  def self.down
    execute "alter table exercises drop order_num"
  end
end
