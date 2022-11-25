class CreateClientes < ActiveRecord::Migration[7.0]
  def change
    create_table :clientes do |t|
      t.string :email
      t.string :password
      t.timestamps
    end
  end
end
