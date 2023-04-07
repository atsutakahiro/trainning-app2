class TrainsController < ApplicationController
  before_action :set_user
  before_action :set_train, only: [:edit, :update, :destroy]

  def new
    @train = @user.trains.build
    @trains = @user.trains.all 
    @parts = ["胸", "肩", "上腕二頭筋", "上腕三頭筋", "腹筋", "背中", "脚"]
  end
  
  def create
    @train = @user.trains.build(train_params)
    @trains = @user.trains.all
    set_exercises
    if @train.save
      flash[:success] = "新規作成に成功しました"
      render '_form.html.erb'
    else
      flash[:error] = "新規作成に失敗しました"
      render 'new'
    end
  end

  def update
    if @train.update(train_params)
      flash[:success] = "更新に成功しました"
      redirect_to user_trains_path(@user)
    else
      flash[:danger] = "更新に失敗しました"
      render 'edit'
    end
  end

  def edit
    set_exercises
  end

  def destroy
    @train.destroy
    flash[:success] = "削除に成功しました"
    redirect_to user_trains_path(@user)
  end

  def index
    @trains = @user.trains.all
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_train
    @train = @user.trains.find(params[:id])
  end

  def set_exercises
    if @train.part == "胸"
      @exercises = ["ベンチプレス", "ダンベルプレス", "インクラインベンチプレス", "インクラインダンベルフライ", "ダンベルフライ", "インクラインチェストプレス", "チェストプレス", "ケーブルカール"]
    elsif @train.part == "肩"
      @exercises = ["ダンベルショルダープレス", "アップライトロウ", "バックプレス", "スミスショルダープレス", "サイドレイズ", "フロントレイズ", "リアレイズ"]
    elsif @train.part == "上腕二頭筋"
      @exercises = ["バーベルカール", "ダンベルカール", "ハンマーカール", "インクラインダンベルカール", "インクラインハンマーカール", "ケーブルカール"]
    elsif @train.part == "上腕三頭筋"
      @exercises = ["フレンチプレス", "オーバーヘッドトライセップスエクステンション", "ケーブルプレス", "ディップス", "ナロープレス"]
    elsif @train.part == "腹筋"
      @exercises = ["アブローラー", "デクラインレッグレイズ", "シットアップ"]
    elsif @train.part == "背中"
    @exercises = ["デッドリフト", "オーバーベントロウ", "チンニング", "ラットプルダウン", "マシンロウ", "ダンベルローイング"]
    else @train.part == "脚"
    @exercises = ["スクワット", "レッグプレス", "レッグエクステンション", "レッグレイズ", "ブルガリアンスクワット"]
    end
  end
    
  def train_params
    params.require(:train).permit(:part, :exercise, :name, :weight, :rep).merge(user_id: params[:user_id])
  end
end
