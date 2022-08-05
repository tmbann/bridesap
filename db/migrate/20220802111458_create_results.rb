class CreateResults < ActiveRecord::Migration[6.1]
  def change
    create_table :results do |t|
      t.references :user, null: false, foreign_key: true
      t.references :pose, null: false, foreign_key: true
      t.integer :score
      t.string :comment

      t.timestamps
    end
  end
end
