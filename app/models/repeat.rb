class Repeat < ApplicationRecord
  belongs_to :train
  
  def rep
    [set_number, self[:weight], rep, remark].join('/')
  end
end
