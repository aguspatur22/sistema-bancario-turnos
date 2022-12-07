class CreateTurnos < ActiveRecord::Migration[7.0]
  def change
    create_table :turnos do |t|
      t.string :motivo
      t.datetime :fecha
      t.string :estado
      t.string :resultado
      
      t.belongs_to :usuario, index: true

      t.belongs_to :cliente , index: true
      t.belongs_to :sucursal , index: true
      t.timestamps
    end
  end
end
