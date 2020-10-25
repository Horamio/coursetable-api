class CreateSpecialities < ActiveRecord::Migration[6.0]
  def change
    create_table :specialities do |t|
      t.references :faculty, null: false, foreign_key: true
      t.string :code
      t.string :name

      t.timestamps
    end
  end
end
