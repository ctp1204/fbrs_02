class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.integer :target_id
      t.integer :target_type
      t.integer :type

      t.timestamps
    end
  end
end
