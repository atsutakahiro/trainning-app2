class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

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
  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end