class AddAssignmentToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :assignment, :string
  end
end
