class AddPositionToEmployee < ActiveRecord::Migration[6.1]
  def change
    add_reference :employees, :position, foreing_key: true
  end
end
