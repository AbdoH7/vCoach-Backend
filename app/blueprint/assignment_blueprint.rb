class AssignmentBlueprint < Blueprinter::Base
  identifier :id

  fields :doctor_id, :instructions, :status, :missed, :notes, :accuracy

  association :exercise, blueprint: ExerciseBlueprint
  association :doctor, blueprint: UserBlueprint
  association :patient, blueprint: UserBlueprint
end
