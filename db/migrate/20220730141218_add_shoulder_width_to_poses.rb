class AddShoulderWidthToPoses < ActiveRecord::Migration[6.1]
  def change
    add_column :poses, :shoulder_width, :integer
  end
end
