class TrainsController < ApplicationController
  def create
    @train = Train.new
    if @train.save
      flash[:success] = "新規作成に成功しました"
      # 保存に成功した場合は、ここに記述した処理が実行されます。
      redirect_to new_user_train_path
    end
  end
end
