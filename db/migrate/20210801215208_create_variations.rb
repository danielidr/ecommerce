class CreateVariations < ActiveRecord::Migration[5.2]
  def change
    create_table :variations do |t|
      t.string :size
      t.string :color

      t.timestamps
    end
  end
end
