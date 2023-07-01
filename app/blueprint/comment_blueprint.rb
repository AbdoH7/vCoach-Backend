class CommentBlueprint < Blueprinter::Base
  identifier :id

  fields :user_id, :announcement_id, :content, :created_at
  association :user, blueprint: UserBlueprint
end