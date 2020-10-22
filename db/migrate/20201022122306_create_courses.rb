class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.references :faculty, null: false, foreign_key: true
      t.string :code
      t.string :name
      t.integer :semester
      t.integer :credits

      t.timestamps
    end
  end
end
