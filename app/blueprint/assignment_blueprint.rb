class AssignmentBlueprint < Blueprinter::Base
  identifier :id

  fields :doctor_id, :instructions, :status, :missed, :notes, :accuracy

  association :exercise, blueprint: ExerciseBlueprint
end