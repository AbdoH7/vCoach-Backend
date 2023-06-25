class ChangeModelAvailableDefaultInExercises < ActiveRecord::Migration[7.0]
  def change
    change_column :exercises, :model_available, :boolean, default: false, null: false
  end
end
