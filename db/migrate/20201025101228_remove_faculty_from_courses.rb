class RemoveFacultyFromCourses < ActiveRecord::Migration[6.0]
  def change
    remove_reference :courses, :faculty, null: false, foreign_key: true
  end
end
