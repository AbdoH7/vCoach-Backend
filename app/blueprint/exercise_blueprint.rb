class ExerciseBlueprint < Blueprinter::Base
    identifier :id
  
    fields :name, :description, :model_available, :model_url, :video, :type, :image, :body_area, :equipment, :instructions
  end
  