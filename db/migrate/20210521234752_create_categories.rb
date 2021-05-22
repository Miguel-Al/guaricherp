class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :nombre_categoria
      t.string :descripcion_categoria

      t.timestamps
    end
  end
end
