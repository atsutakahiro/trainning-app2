class TrainsController < ApplicationController
  before_action :set_user, only: [:input_exercise, :index, :create, :edit, :destroy, :update]
  before_action :set_train, only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy, :new, :show]

  def input_exercise
    @train = @user.trains.build(train_params)
    @train.date = params[:train][:date] # 日付を@trainにセット
    set_exercises
    render '_form.html.erb'
  end
  

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
    if @train.valid? # バリデーションチェック
      @train.save
      flash[:success] = "トレーニングのデータを登録しました"
      redirect_to user_trains_path(@user)
    else
      flash[:danger] = "登録に失敗しました。レップ数を入力してください"
      render '_form.html.erb'
    end
  end
  

  def update
    if train_params[:rep].present?
      @train.update(train_params)
      flash[:success] = "データを更新しました"
  
      # 直前のページによってリダイレクト先を変更
      if request.referer.include?('past_edit')
        redirect_to past_trains_user_trains_path(@user, date: @train.created_at.to_date)
      else
        redirect_to user_trains_path(@user)
      end
    else
      flash[:danger] = "データの更新に失敗しました"
      redirect_to new_user_train_path
    end
  end
  
  

  def edit
    set_exercises
  end

  def destroy
    @train.destroy
    flash[:success] = "トレーニング記録が削除されました"
    # デフォルトのリダイレクト先を指定して、リダイレクトする
    redirect_back(fallback_location: user_trains_url(@user))
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

  def past_edit
    @user = User.find(params[:user_id])
    @train = @user.trains.find(params[:id])
  end
  
  def past_trains
    @user = User.find(params[:user_id])
  
    # パラメータから日付が渡されている場合はその日付を、渡されていない場合は今日の日付を使用
    @date = params[:date] ? params[:date].to_date : Date.today
  
    @trains = @user.trains.where(created_at: @date.beginning_of_day..@date.end_of_day)
  end
# 前回のトレーニング記録を表示する
def past_update
  @latest_date = current_user.trains.maximum(:created_at)
  @trains = current_user.trains.where("DATE(created_at) = DATE(?)", @latest_date).order(created_at: :desc)
end


  
  

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_train
    @train = @user.trains.find(params[:id])
  end

  def correct_user
    @user = User.find(params[:user_id])
    redirect_to root_path unless @user == current_user
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
    params.require(:train).permit(:part, :date, :exercise, :name, :weight, :rep, :note).merge(user_id: params[:user_id])
  end
end
