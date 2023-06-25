module Api
	module V1
		class AssignmentsController < ApplicationController
			def create
				authorize Assignment
				assignments=[]
				assignments_params[:date].each do |date|
					assignment = @current_user.assignments_as_doctor.build(assignments_params)
					assignment.patient_id = patient || return
					assignment.date = date
					if assignment.valid?
						assignment.save
						assignments.push(assignment)
					else
						render json: { errors: assignment.errors.full_messages }, status: :unprocessable_entity
						return
					end
				end
				render json: { assignment: AssignmentBlueprint.render_as_hash(assignments) }, status: :created
			end

			def index
				authorize Assignment
				assignments = policy_scope(Assignment)
											.where(assignments_params[:patient_id]&&{patient_id: assignments_params[:patient]})
											.where(assignments_params[:doctor_id]&&{id: assignments_params[:doctor_id]})
				render json: {assignments: AssignmentBlueprint.render_as_hash(assignments)}, status: 200
			end

			def show
				authorize Assignment
				assignment = Assignment.find(params[:id])
				render json: {assignment: AssignmentBlueprint.render_as_hash(assignment)}, status: 200
			end

			def update
				authorize Assignment
				assignment = Assignment.find(params[:id])
				assignment.update(update_params)
				render json: {assignment: AssignmentBlueprint.render_as_hash(assignment)}, status: 200
			end

			def destroy
				authorize Assignment
				assignment = Assignment.find(params[:id])
				assignment.destroy
				render json: {assignment: AssignmentBlueprint.render_as_hash(assignment)}, status: 200
			end

			def doctor_update
				authorize Assignment
				assignment = Assignment.find(params[:id])
				assignment.update(doctor_update_params)
				render json: {assignment: AssignmentBlueprint.render_as_hash(assignment)}, status: 200
			end

			private

			def assignments_params
				params.permit(:doctor_id, :exercise_id, :patient, :status, :completed_date, :notes, :score, instructions:{}, date: [])
			end

			def doctor_update_params
				params.permit(:status, :completed_date, :notes, :score, :date,  instructions: {})
			end

			def update_params
				params.permit(:status)
			end

			def patient
				patient_ids = DoctorPatientAssignment.where(doctor_id: @current_user.id).pluck(:patient_id)
				return params[:patient_id] if patient_ids.include?(params[:patient_id].to_i)
				render json: { errors: "You are not authorized to perform this action" }, status: :unauthorized
				return nil
			end

		end
	end
end
  