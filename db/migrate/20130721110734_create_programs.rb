class CreatePrograms < ActiveRecord::Migration
  def up
    create_table :programs do |t|
      t.string :title
      t.string :desc
      t.string :categories
      t.string :aspect
      t.timestamp :start_time
      t.timestamp :end_time
      t.integer :duration
      t.integer :channels_id

      t.timestamps
    end
  end

  def down
    drop_table :programs
  end
end
