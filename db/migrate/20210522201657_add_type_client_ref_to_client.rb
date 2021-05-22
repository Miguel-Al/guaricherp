class AddTypeClientRefToClient < ActiveRecord::Migration[6.1]
  def change
    add_reference :clients, :type_client, foreing_key: true
  end
end
