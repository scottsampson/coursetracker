class CreateTeches < ActiveRecord::Migration
  def self.up
    create_table :teches do |t|
      t.integer :project_id
      t.integer :course_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :teches
  end
end
