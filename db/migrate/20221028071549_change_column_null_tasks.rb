class ChangeColumnNullTasks < ActiveRecord::Migration[6.1]
  def up
    change_column :tasks, :title, :string, null: false 
  end

  def down
    change_column :tasks, :title, :string, null: true 
  end
end
