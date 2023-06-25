class ChangeMissedAndStatusDefaultsInAssignments < ActiveRecord::Migration[7.0]
  def change
    change_column_default :assignments, :missed, from: nil, to: false
    change_column_default :assignments, :status, from: nil, to: false
  end
end
