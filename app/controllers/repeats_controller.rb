class RepeatsController < ApplicationController
  def create
    @train = Train.find(params[:train_id])
    @repeat = @train.repeats.build(repeat_params)
    if @repeat.save
      flash[:success] = "Repeatを追加しました！"
    else
      flash[:danger] = "Repeatの追加に失敗しました"
    end
    redirect_to @train
  end

  def rep     
    [set_number, weight, repetition, remark].join('/')
  end
  
  private

  def repeat_params
    params.require(:repeat).permit(:weight, :rep, :remark)
  end
end
