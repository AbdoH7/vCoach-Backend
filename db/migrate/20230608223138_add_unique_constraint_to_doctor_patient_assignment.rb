class AddUniqueConstraintToDoctorPatientAssignment < ActiveRecord::Migration[7.0]
  def change
    reversible do |dir|
      dir.up do
        # Add a unique index
        execute <<-SQL
          CREATE UNIQUE INDEX index_doctor_patient_assignments_on_doctor_id_and_patient_id
          ON doctor_patient_assignments (doctor_id, patient_id)
        SQL
      end

      dir.down do
        # Remove the unique index
        execute <<-SQL
          DROP INDEX index_doctor_patient_assignments_on_doctor_id_and_patient_id
        SQL
      end
    end
  end
end
