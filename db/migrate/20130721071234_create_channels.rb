class CreateChannels < ActiveRecord::Migration
  def up
    create_table :channels do |t|
      t.string :name

      t.timestamps
    end
    add_index :channels , :name
  end

  def down
    drop_table :channels
  end
end
