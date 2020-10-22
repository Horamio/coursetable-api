class CreateFacultiesProfessorsJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_table :faculties_professors, id: false do |t|
      t.belongs_to :faculty
      t.belongs_to :professor
    end
  end
end
