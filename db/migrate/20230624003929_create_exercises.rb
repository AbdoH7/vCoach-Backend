class CreateExercises < ActiveRecord::Migration[7.0]
  def change
    create_table :exercises do |t|
      t.string :name, null: false
      t.string :description
      t.boolean :model_available
      t.string :model_url
      t.string :video
      t.string :type
      t.string :body_area
      t.string :equipment

      t.timestamps
    end
  end
end
