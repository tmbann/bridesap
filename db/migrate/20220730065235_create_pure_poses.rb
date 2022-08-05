class CreatePurePoses < ActiveRecord::Migration[6.1]
  def change
    create_table :pure_poses do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :pure_shoulder_width

      t.timestamps
    end
  end
end
