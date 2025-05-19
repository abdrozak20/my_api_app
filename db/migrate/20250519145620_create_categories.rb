class CreateCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :categories do |t|
      t.string :code
      t.string :name
      t.string :created_by

      t.timestamps
    end
  end
end
