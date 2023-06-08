class CreateDoctorPatientAssignments < ActiveRecord::Migration[7.0]
  def up
    create_table :doctor_patient_assignments do |t|
      t.integer :doctor_id, null: false
      t.integer :patient_id, null: false

      t.timestamps
    end

    execute <<-SQL
      CREATE FUNCTION is_type_doctor(user_id INTEGER)
      RETURNS BOOLEAN AS $$
        SELECT user_type = 'doctor'
        FROM users
        WHERE id = user_id
      $$ LANGUAGE SQL
    SQL

    execute <<-SQL
      CREATE FUNCTION is_type_patient(user_id INTEGER)
      RETURNS BOOLEAN AS $$
        SELECT user_type = 'patient'
        FROM users
        WHERE id = user_id
      $$ LANGUAGE SQL
    SQL

    execute <<-SQL
      ALTER TABLE doctor_patient_assignments
      ADD CONSTRAINT ck_doctor_patient_assignments_doctor
      CHECK (doctor_id IS NOT NULL AND is_type_doctor(doctor_id))
    SQL

    execute <<-SQL
      ALTER TABLE doctor_patient_assignments
      ADD CONSTRAINT ck_doctor_patient_assignments_patient
      CHECK (patient_id IS NOT NULL AND is_type_patient(patient_id))
    SQL

    add_foreign_key :doctor_patient_assignments, :users, column: :doctor_id, on_delete: :nullify
    add_foreign_key :doctor_patient_assignments, :users, column: :patient_id, on_delete: :nullify
  end

  def down
    remove_foreign_key :doctor_patient_assignments, column: :doctor_id
    remove_foreign_key :doctor_patient_assignments, column: :patient_id

    execute <<-SQL
      ALTER TABLE invites DROP CONSTRAINT ck_doctor_patient_assignments_doctor
    SQL

    execute <<-SQL
      ALTER TABLE invites DROP CONSTRAINT ck_doctor_patient_assignments_patient
    SQL

    execute <<-SQL
      DROP FUNCTION is_type_doctor
    SQL


    execute <<-SQL
      DROP FUNCTION is_type_patient
    SQL

  end
end
