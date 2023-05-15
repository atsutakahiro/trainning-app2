class Exercise < ApplicationRecord
  belongs_to :user
  validates :name, uniqueness: { scope: :user_id, message: "その種目名は既に存在します。" }
end
