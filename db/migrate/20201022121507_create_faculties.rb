class CreateFaculties < ActiveRecord::Migration[6.0]
  def change
    create_table :faculties do |t|
      t.references :college, null: false, foreign_key: true
      t.string :code
      t.string :name

      t.timestamps
    end
  end
end
