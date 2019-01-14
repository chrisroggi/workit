class WorkoutsController < ApplicationController

  requires_authentication

  PERMITTED_ATTRIBUTES = [ :id, :name, :exercise_ids ]

  def show
    workout = Workout.find_by( id: params[ :id ], user_id: user.id )

    if workout.present?
      render json: workout.response, status: :ok
    else
      render json: { errors: [ 'Workout not found' ], }, status: :not_found
    end
  end

  def index
    workouts = Workout.where(
      params.permit( PERMITTED_ATTRIBUTES ).merge( user_id: user.id )
    )

    render json: workouts.map( &:response ), status: :ok
  end

  def create
    workout = Workout.new( workout_params.merge( user: user ) )
    workout.add_exercises( params[ :workout ][ :exercise_ids ] )

    if workout.save
      render json: workout.response, status: :created
    else
      render json: { errors: workout.errors.full_messages }, status: :bad_request
    end
  end

  def update
    workout = Workout.find_by( id: params[ :id ], user_id: user.id )

    if workout.present?
      workout.assign_attributes( workout_params )
      workout.add_exercises( params[ :workout ][ :exercise_ids ] )

      if workout.save
        render json: workout.response, status: :ok
      else
        render json: { errors: workout.errors.full_messages }, status: :bad_request
      end
    else
      render json: { errors: [ 'Workout not found' ], }, status: :not_found
    end
  end

  private

  def workout_params
    params.require( :workout ).permit( PERMITTED_ATTRIBUTES )
  end

end
