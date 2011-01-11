class CoursesUsers < ActiveRecord::Migration
  def self.up
    execute "create table courses_users (course_id int(11), user_id int(11),know tinyint(4), primary key(course_id,user_id))"
  end

  def self.down
    execute "drop table courses_users"
  end
end
