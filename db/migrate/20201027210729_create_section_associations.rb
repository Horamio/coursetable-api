class CreateSectionAssociations < ActiveRecord::Migration[6.0]
  def change
    create_table :section_associations do |t|
      t.bigint :section_1_id
      t.bigint :section_2_id
      t.boolean :intersect
      t.integer :intersect_minutes
      t.boolean :enabled

      t.timestamps
    end
    add_index :section_associations, :section_1_id
    add_index :section_associations, :section_2_id
  end
end
