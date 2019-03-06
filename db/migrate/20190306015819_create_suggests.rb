class CreateSuggests < ActiveRecord::Migration[5.2]
  def change
    create_table :suggests do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.text :status
      t.text :content
      t.string :author
      t.string :categories

      t.timestamps
    end
  end
end
