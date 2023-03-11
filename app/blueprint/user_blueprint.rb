class UserBlueprint < Blueprinter::Base
    identifier :id
  
    fields :first_name, :last_name, :email, :DOB, :user_type, :phone_number
  end