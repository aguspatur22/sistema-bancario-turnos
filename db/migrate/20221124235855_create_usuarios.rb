class CreateUsuarios < ActiveRecord::Migration[7.0]
  def change
    create_table :usuarios do |t|
      t.string :nombre
      t.string :apellido
      t.string :email
      t.string :password
      t.belongs_to :sucursal, index: :unique
      t.timestamps
    end
  end
end
