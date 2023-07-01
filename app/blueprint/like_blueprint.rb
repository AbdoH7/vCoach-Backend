class LikeBlueprint < Blueprinter::Base
  identifier :id

  fields :user_id, :announcement_id
  association :user, blueprint: UserBlueprint
end