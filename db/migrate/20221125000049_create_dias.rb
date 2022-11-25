class CreateDias < ActiveRecord::Migration[7.0]
  def change
    create_table :dias do |t|
      t.integer :dia
      t.integer :inicio
      t.integer :fin
      t.belongs_to :sucursal, index: true
      t.timestamps
    end
  end
end
