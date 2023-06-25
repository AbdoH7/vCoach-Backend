module Api
	module V1
		class ExercisesController < ApplicationController
			def index
				exercises = Exercise.all
				render json: {exercises: ExerciseBlueprint.render_as_hash(exercises)}, status: 200
			end
		end
	end
end
  