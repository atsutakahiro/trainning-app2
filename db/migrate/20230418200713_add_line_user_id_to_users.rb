class AddLineUserIdToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :line_user_id, :string
    # unique: trueオプションを削除する
    add_index :users, :line_user_id
  end
end
