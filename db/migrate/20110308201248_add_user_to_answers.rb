class AddUserToAnswers < ActiveRecord::Migration
  def self.up
    add_column :answers, :user_id, :integer
  end

  def self.down
    remove_column :answers, :user_id
  end
end