class CreateTimeblocks < ActiveRecord::Migration[6.0]
  def change
    create_table :timeblocks do |t|
      t.references :section, null: false, foreign_key: true
      t.time :start_time
      t.time :end_time
      t.string :day
      t.string :session_type
      t.string :place

      t.timestamps
    end
  end
end
