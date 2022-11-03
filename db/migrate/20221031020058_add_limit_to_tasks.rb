class AddLimitToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :limit, :date, null: false, default: -> { '(CURRENT_DATE)' }
  end
end
