class AddImageToExercises < ActiveRecord::Migration[7.0]
  def change
    add_column :exercises, :image, :string
  end
end
