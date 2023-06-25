class AddInstructionsToExercises < ActiveRecord::Migration[7.0]
  def change
    add_column :exercises, :instructions, :jsonb, default: {}, null: false
  end
end
