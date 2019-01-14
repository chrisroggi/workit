class ExercisesController < ApplicationController

  requires_authentication

  PERMITTED_ATTRIBUTES = [ :id, :name ]

  def show
    exercise = Exercise.find_by_id( params[ :id ] )

    if exercise.present?
      render json: exercise, status: :ok
    else
      render json: { errors: [ 'Exercise not found' ], }, status: :not_found
    end
  end

  def index
    exercises = Exercise.where( params.permit( PERMITTED_ATTRIBUTES ) )

    render json: exercises, status: :ok
  end

  def create
    exercise = Exercise.new( exercise_params )

    if exercise.save
      render json: exercise, status: :created
    else
      render json: { errors: exercise.errors.full_messages }, status: :bad_request
    end
  end

  def update
    exercise = Exercise.find_by_id( params[ :id ] )

    if exercise.present?
      exercise.assign_attributes( exercise_params )

      if exercise.save
        render json: exercise, status: :ok
      else
        render json: { errors: exercise.errors.full_messages }, status: :bad_request
      end
    else
      render json: { errors: [ 'Exercise not found' ], }, status: :not_found
    end
  end

  private

  def exercise_params
    params.require( :exercise ).permit( PERMITTED_ATTRIBUTES )
  end

end
