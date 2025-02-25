class AddBusinessInfoToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :business_name, :string
    add_column :users, :cnpj, :string
  end
end
