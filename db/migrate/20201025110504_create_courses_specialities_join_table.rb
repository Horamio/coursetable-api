class CreateCoursesSpecialitiesJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_table :courses_specialities, id: false do |t|
      t.belongs_to :course
      t.belongs_to :speciality
    end
  end
end