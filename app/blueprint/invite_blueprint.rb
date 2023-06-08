class InviteBlueprint < Blueprinter::Base
  identifier :id

  fields :user_id, :email, :token, :accepted
end
