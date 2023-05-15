class ExercisesController < ApplicationController
  before_action :set_user

  def new
    @exercise = Exercise.new(part: params[:part])
  end
  

  def create
    @exercise = current_user.exercises.build(exercise_params)
    if @exercise.valid?
       @exercise.save
      flash[:success] = '新しい種目名が作成されました。'
      redirect_to new_user_train_path
    else
      flash[:danger] = 'すでに存在する種目名は追加できません'
      render :new
    end
  end
  
  

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def exercise_params
    params.require(:exercise).permit(:part, :name)
  end
end
