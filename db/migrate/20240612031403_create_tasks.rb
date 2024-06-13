class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :description
      t.float :price
      t.datetime :date
      t.string :place
      t.string :status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
