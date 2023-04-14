class UsersController < ApplicationController

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user #保存成功後、ログインします
      flash[:success] = "新規作成に成功しました"
      # 保存に成功した場合は、ここに記述した処理が実行されます。
      redirect_to @user
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def new
      @user = User.new
  end

  def part
    @user = User.find(params[:id])
    @part = params[:part]

  if @part.present?
    @trains = @user.trains.where(part: @part)
  elsif params[:exercise].present?
    @trains = @user.trains.where(exercise: params[:exercise])
  else
    @trains = @user.trains
  end

  # 新しい検索フォームを表示する前に、params[:part]とparams[:exercise]をnilに設定する
  params[:part] = nil
  params[:exercise] = nil
end
  
  def show
    @user = User.find(params[:id])
    @date = Date.parse(params[:date]) rescue Date.today
    @trains = @user.trains.where(created_at: @date.beginning_of_day..@date.end_of_day)
    @exercise = @trains.first.part if @trains.present?
  end

  

  

  
  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end