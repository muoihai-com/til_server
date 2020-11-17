class CreateBuilderFiles < ActiveRecord::Migration[5.2]
  def change
    create_table :builder_files do |t|
      t.string :output, index: true
      t.references :fileable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
