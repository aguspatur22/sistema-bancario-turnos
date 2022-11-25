class CreateSucursales < ActiveRecord::Migration[7.0]
  def change
    create_table :sucursales do |t|
      t.string :nombre
      t.string :direccion
      t.integer :telefono
      t.belongs_to :usuario, index: :unique
      t.timestamps
    end
  end
end
