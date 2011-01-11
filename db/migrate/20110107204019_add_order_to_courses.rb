class AddOrderToCourses < ActiveRecord::Migration
  def self.up
    execute "alter table courses add order_num int(4)"
  end

  def self.down
    execute "alter table courses drop order_num"
  end
end
