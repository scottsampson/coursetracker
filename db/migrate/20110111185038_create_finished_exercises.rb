class CreateFinishedExercises < ActiveRecord::Migration
  def self.up
    create_table :finished_exercises do |t|
      t.integer :exercise_id
      t.integer :user_id
      t.boolean :finished
      t.timestamps
    end
  end

  def self.down
    drop_table :finished_exercises
  end
end
