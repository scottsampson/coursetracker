class CreateProjectsUsers < ActiveRecord::Migration
  def self.up
    create_table :projects_users do |t|
      t.integer :project_id
      t.integer :user_id
      t.boolean :submitted

      t.timestamps
    end
  end

  def self.down
    drop_table :projects_users
  end
end
