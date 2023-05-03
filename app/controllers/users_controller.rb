class UsersController < ApplicationController
before_action :correct_user, only: [:edit, :update, :show]
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user #保存成功後、ログインします
      flash[:success] = "新規登録に成功しました"
      # 保存に成功した場合は、ここに記述した処理が実行されます。
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def line_id
    @user = User.find(params[:id])
  end

  def new
      @user = User.new
  end

  def part
    @user = User.find(params[:id])
    @part = params[:part]
    if @part.present? && params[:exercise].present?
      @trains = @user.trains.where(exercise: params[:exercise]).order(created_at: :asc)
    elsif @part.present?
      @trains = @user.trains.where(part: @part).order(created_at: :asc)
    elsif params[:exercise].present?
      @trains = @user.trains.where(exercise: params[:exercise]).order(created_at: :asc)
    else
      @trains = nil
    end

    @filtered_trains = params[:exercise].present? ? @trains.where(exercise: params[:exercise]) : []
  
    params[:part] = nil
    params[:exercise] = nil
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "ユーザー情報を更新しました"
      redirect_to @user
    else
      render 'edit'
    end
  end
  

  

  
  
  def show
    @user = User.find(params[:id])
    @parts = Train::PARTS
    
    if params[:date].present?
      @date = Date.parse(params[:date]) rescue nil
      @trains = @user.trains.where(created_at: @date.beginning_of_day..@date.end_of_day) if @date.present?
    else
      @trains = @user.trains
    end

    if params[:part].present?
      @part = params[:part]
      @trains = @trains.where(part: @part)
    end
  end
  

  

  

  
  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :line_user_id)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
    end
end