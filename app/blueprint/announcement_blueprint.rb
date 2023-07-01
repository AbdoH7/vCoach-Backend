class AnnouncementBlueprint < Blueprinter::Base
  identifier :id

  fields :user_id, :content, :likes_count, :comments_count, :created_at, :is_liked, :user_name

  association :user, blueprint: UserBlueprint
  association :comments, blueprint: CommentBlueprint
  association :likes, blueprint: LikeBlueprint
end