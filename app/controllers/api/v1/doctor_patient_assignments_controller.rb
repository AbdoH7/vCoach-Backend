module Api
  module V1
    class DoctorPatientAssignmentsController < ApplicationController
      def create
        ##this will need to be refactored
        authorize DoctorPatientAssignment
        invite = Invite.find_by(token: invite_param)   
        if (invite && invite.accepted == false)
          doctor = User.find(invite.user_id)
          patient = @current_user  
          begin
            assignment = DoctorPatientAssignment.create(doctor_id: doctor.id, patient_id: patient.id)       
            if assignment.persisted?
              invite.update(accepted:true)
              render json: { message: "Invite accepted" }, status: :ok
            else
              render json: { error: "Invite not accepted" }, status: :unprocessable_entity
            end       
          rescue ActiveRecord::RecordNotUnique => e
            render json: { error: "You're already assigned to that doctor" }, status: :unprocessable_entity
          end    
        else
          render json: { error: "Invite not found or already used" }, status: :not_found
        end
      end

      def index
        authorize DoctorPatientAssignment
        users = policy_scope(DoctorPatientAssignment)
        render json: { users: UserBlueprint.render_as_hash(users)}, status: 200
      end

      def remove
        assignment = if doctor?
          DoctorPatientAssignment.find_by(doctor_id: @current_user.id, patient_id: remove_id)
        elsif patient?
          DoctorPatientAssignment.find_by(doctor_id: remove_id, patient_id: @current_user.id)
        end
      
        if assignment
          if assignment.destroy
            render json: { message: doctor? ? "Patient removed" : "Doctor removed" }, status: 200
          else
            render json: { error: doctor? ? "Patient not removed" : "Doctor not removed" }, status: 422
          end
        else
          render json: { error: "Assignment not found" }, status: 404
        end
      end

      private

      def remove_id
        params.permit(:id)[:id]
      end

      def invite_param
        params.permit(:invite_token)[:invite_token]
      end

      def doctor?
        @current_user.user_type == "doctor"
      end

      def patient?
        @current_user.user_type == "patient"
      end
    end
  end
end
  