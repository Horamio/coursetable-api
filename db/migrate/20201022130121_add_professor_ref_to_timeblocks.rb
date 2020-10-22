class AddProfessorRefToTimeblocks < ActiveRecord::Migration[6.0]
  def change
    add_reference :timeblocks, :professor, null: false, foreign_key: true
  end
end
