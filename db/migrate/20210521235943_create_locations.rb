class CreateLocations < ActiveRecord::Migration[6.1]
  def change
    create_table :locations do |t|
      t.string :nombre_lugar

      t.timestamps
    end
  end
end
