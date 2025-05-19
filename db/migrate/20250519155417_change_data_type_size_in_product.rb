class ChangeDataTypeSizeInProduct < ActiveRecord::Migration[8.0]
  def change
    change_column :products, :size, :string
  end
end
