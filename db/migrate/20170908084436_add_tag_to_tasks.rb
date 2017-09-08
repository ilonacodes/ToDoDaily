class AddTagToTasks < ActiveRecord::Migration[5.1]
  def change
    add_column :tasks, :tag, :string
  end
end
