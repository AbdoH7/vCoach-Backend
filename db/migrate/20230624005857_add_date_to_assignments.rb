class AddDateToAssignments < ActiveRecord::Migration[7.0]
  def change
    add_column :assignments, :date, :date, null: false
  end
end
