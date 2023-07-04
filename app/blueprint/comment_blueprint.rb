class CommentBlueprint < Blueprinter::Base
  identifier :id

  fields :user_id, :announcement_id, :content, :created_at, :user_name, :time_passed
  association :user, blueprint: UserBlueprint
end