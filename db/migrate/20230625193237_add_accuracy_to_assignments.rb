class AddAccuracyToAssignments < ActiveRecord::Migration[7.0]
  def change
    add_column :assignments, :accuracy, :float
  end
end
