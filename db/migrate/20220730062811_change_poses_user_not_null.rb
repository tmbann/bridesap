class ChangePosesUserNotNull < ActiveRecord::Migration[6.1]
  def change
    execute 'DELETE FROM poses;'
    change_column_null :poses, :user_id, false
  end
end
