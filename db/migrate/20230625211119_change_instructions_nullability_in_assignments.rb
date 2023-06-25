class ChangeInstructionsNullabilityInAssignments < ActiveRecord::Migration[7.0]
  def change
    change_column :assignments, :instructions, :jsonb,  default: {}, null: false
  end
end
