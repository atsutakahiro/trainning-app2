class TrainsController < ApplicationController
  
  def new
    @user = User.find(params[:user_id])
    @train = @user.trains.build
  end

  def create
    @user = User.find(params[:user_id])
    @train = @user.trains.build(train_params)
    if @train.save
      flash[:success] = "新規作成に成功しました"
      redirect_to user_trains_path(@user)
    else
      flash.now[:danger] = "新規作成に失敗しました"
      render 'new'
    end
  end

  def index
    @trains = Train.all
  end

  private

  def train_params
    params.require(:train).permit(:part, :exercise, :name, :weight, :rep)
  end
end