class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.refernces :user
      t.references :activity, foreign_key: true

      t.timestamps
    end
  end
end
