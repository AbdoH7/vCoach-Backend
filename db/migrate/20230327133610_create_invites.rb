class CreateInvites < ActiveRecord::Migration[7.0]
  def up
    create_table :invites do |t|
      t.integer :user_id, null: false
      t.string :email, null: false
      t.string :token

      t.timestamps
    end

    execute <<-SQL
      CREATE FUNCTION is_doctor(user_id INTEGER)
      RETURNS BOOLEAN AS $$
        SELECT user_type = 'doctor'
        FROM users
        WHERE id = user_id
      $$ LANGUAGE SQL
    SQL

    execute <<-SQL
      ALTER TABLE invites
      ADD CONSTRAINT ck_user_type
      CHECK (user_id IS NOT NULL AND is_doctor(user_id))
    SQL

    add_foreign_key :invites, :users, column: :user_id, on_delete: :nullify
  end

  def down
    remove_foreign_key :invites, column: :user_id

    execute <<-SQL
      ALTER TABLE invites DROP CONSTRAINT ck_user_type
    SQL

    execute <<-SQL
      DROP FUNCTION is_doctor
    SQL

    drop_table :invites
  end
end
