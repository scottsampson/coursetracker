class ModifyCoursesUsers < ActiveRecord::Migration
  def self.up
    change_column :courses_users, :know, :integer
  end

  def self.down
    change_column :courses_users, :know, :boolean
  end
end
