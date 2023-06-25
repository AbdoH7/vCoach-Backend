class CreateAssignments < ActiveRecord::Migration[7.0]
  def up
    create_table :assignments do |t|
      t.references :exercise, null: false, foreign_key: { to_table: :exercises }
      t.references :doctor, null: false, foreign_key: { to_table: :users }
      t.references :patient, null: false, foreign_key: { to_table: :users }
      t.jsonb :instructions
      t.boolean :status
      t.boolean :missed
      t.string :notes

      t.timestamps
    end

    execute <<-SQL
      CREATE FUNCTION is_type_doctor_for_assignments(user_id BIGINT)
      RETURNS BOOLEAN AS $$
        SELECT user_type = 'doctor'
        FROM users
        WHERE id = user_id
      $$ LANGUAGE SQL
    SQL

    execute <<-SQL
      CREATE FUNCTION is_type_patient_for_assignments(user_id BIGINT)
      RETURNS BOOLEAN AS $$
        SELECT user_type = 'patient'
        FROM users
        WHERE id = user_id
      $$ LANGUAGE SQL
    SQL

    execute <<-SQL
      ALTER TABLE assignments
      ADD CONSTRAINT ck_assignments_doctor
      CHECK (doctor_id IS NOT NULL AND is_type_doctor_for_assignments(doctor_id))
    SQL

    execute <<-SQL
      ALTER TABLE assignments
      ADD CONSTRAINT ck_assignments_patient
      CHECK (patient_id IS NOT NULL AND is_type_patient_for_assignments(patient_id))
    SQL

    # add_foreign_key :assignments, :users, column: :doctor_id, on_delete: :nullify
    # add_foreign_key :assignments, :users, column: :patient_id, on_delete: :nullify
  end

  def down
    # remove_foreign_key :assignments, column: :doctor_id
    # remove_foreign_key :assignments, column: :patient_id

    execute <<-SQL
      ALTER TABLE assignments DROP CONSTRAINT ck_assignments_doctor
    SQL

    execute <<-SQL
      ALTER TABLE assignments DROP CONSTRAINT ck_assignments_patient
    SQL

    execute <<-SQL
    DROP FUNCTION is_type_doctor_for_assignments
    SQL

    execute <<-SQL
      DROP FUNCTION is_type_patient_for_assignments
    SQL

  end
end
