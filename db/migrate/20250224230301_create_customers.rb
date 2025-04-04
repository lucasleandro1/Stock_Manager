class CreateCustomers < ActiveRecord::Migration[8.0]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :cpf_cnpj
      t.string :phone
      t.string :email
      t.text :address

      t.timestamps
    end
  end
end
