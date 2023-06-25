class ExerciseBlueprint < Blueprinter::Base
    identifier :id
  
    fields :name, :description, :model_available, :model_url, :video, :type, :body_area, :equipment, :instructions
  end
  