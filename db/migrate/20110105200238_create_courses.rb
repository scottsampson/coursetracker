class CreateCourses < ActiveRecord::Migration
  def self.up
    create_table :courses do |t|
      t.string :name
      t.integer :target_id
      t.integer :level_id

      t.timestamps
    end
  end

  def self.down
    drop_table :courses
  end
end
