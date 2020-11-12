class CreateItemGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :item_groups do |t|
      t.references :item, foreign_key: true
      t.references :group, foreign_key: true

      t.timestamps
    end
  end
end
