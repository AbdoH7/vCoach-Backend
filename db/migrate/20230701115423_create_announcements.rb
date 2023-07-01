
class CreateAnnouncements < ActiveRecord::Migration[7.0]
  def up 
    create_table :announcements do |t|
      t.string :content
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  
    #reusing the same functions from the assignments migration
    #the same function logic is repeated 3 times in the 3 migrations and will need to unify them in the future
    execute <<-SQL
      ALTER TABLE announcements
      ADD CONSTRAINT ck_announcements_doctor
      CHECK (user_id IS NOT NULL AND is_type_doctor_for_assignments(user_id))
    SQL
  end
  
  def down
    
    execute <<-SQL
      ALTER TABLE announcements DROP CONSTRAINT ck_announcements_doctor
    SQL
        
    drop_table :announcements  
  end
end
