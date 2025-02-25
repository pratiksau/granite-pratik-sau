class MakeTitleNotNullable < ActiveRecord::Migration[7.1]
  def change
    change_column_null :tasks, :title, false
  end
end
