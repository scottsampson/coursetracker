class CreatePrerequisites < ActiveRecord::Migration
  def self.up
    execute "create table prerequisites (course_id int(11),exercise_id int(11), primary key (course_id, exercise_id))"
  end

  def self.down
    execute "drop table prerequisites"
  end
end
