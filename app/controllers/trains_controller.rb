class TrainsController < ApplicationController
  
  def new
    @user = User.find(params[:user_id])
    @train = @user.trains.build
    @trains = @user.trains.all 
    @parts = ["胸", "肩", "上腕二頭筋", "上腕三頭筋", "腹筋", "背中", "脚"]
  end
  
  def create
    @user = User.find(params[:user_id])
    @train = @user.trains.build(train_params)
    @trains = @user.trains.all # この行を追加
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

    if @train.save
      flash[:success] = "新規作成に成功しました"
      render '_form.html.erb'
    else
      flash[:error] = "新規作成に失敗しました"
      render 'new'
    end
  end

  def update
    @user = User.find(params[:user_id])
    @train = @user.trains.find(params[:id])
    if @train.update(train_params)
      flash[:success] = "更新に成功しました"
      redirect_to user_trains_path(@user)
    else
      flash[:danger] = "更新に失敗しました"
      render 'edit'
    end
  end

    
  def index
    @user = User.find(params[:user_id])
    @trains = @user.trains.all
  end

  private

  def train_params
    params.require(:train).permit(:part, :exercise, :name, :weight, :rep).merge(user_id: params[:user_id])
  end
end