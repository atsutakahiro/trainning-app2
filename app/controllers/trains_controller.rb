class TrainsController < ApplicationController
  before_action :set_user
  before_action :set_train, only: [:edit, :update, :destroy]

  def new
    @train = @user.trains.build
    @trains = @user.trains.all 
    @parts = Train::PARTS
  end
  
  def create
    @train = @user.trains.build(train_params)
    @train.created_at = params[:train][:date]
    @trains = @user.trains.all
    set_exercises
    if @train.save
      flash[:success] = "部位を選択しました"
      render '_form.html.erb'
    else
      flash[:error] = "部位の選択に失敗しました"
      render 'new'
    end
  end

  def update
    if train_params[:rep].present?
      @train.update(train_params)
      flash[:success] = "種目を選択しました"
      redirect_to user_trains_path(@user)
    else
      flash[:danger] = "種目の選択に失敗しました"
      redirect_to new_user_train_path
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
    @trains = @user.trains
    if @trains.present?
      @latest_date = @trains.last.created_at.to_date
    else
      @latest_date = Date.today
    end
  end

  def show
    @date = Date.parse(params[:date]) # 日付の取得
    @trains = @user.trains.where(created_at: @date.beginning_of_day..@date.end_of_day) # 指定された日付のトレーニング情報の取得
  end

  def past_trains
    @user = User.find(params[:user_id])
    @date = params[:date].to_date
    @trains = @user.trains.where(created_at: @date.beginning_of_day..@date.end_of_day)
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
    params.require(:train).permit(:part, :exercise, :name, :weight, :rep, :note).merge(user_id: params[:user_id])
  end
end
