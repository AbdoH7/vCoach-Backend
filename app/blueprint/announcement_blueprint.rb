class AnnouncementBlueprint < Blueprinter::Base
  identifier :id

  fields :user_id, :content, :likes_count, :comments_count, :created_at, :is_liked, :user_name

  association :user, blueprint: UserBlueprint
  association :comments, blueprint: CommentBlueprint
  association :likes, blueprint: LikeBlueprint

  view :default do
    field :is_liked do |announcement, options|
      current_user = options[:current_user]
      # Logic to determine if the current user has liked the announcement
      current_user&.liked_announcements&.include?(announcement)
    end

    field :like_id do |announcement, options|
      current_user = options[:current_user]
      # Logic to determine if the current user has liked the announcement
      like = current_user&.likes&.find_by(announcement_id: announcement.id)
      like&.id
    end
  end
end
