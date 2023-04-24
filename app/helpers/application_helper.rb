module ApplicationHelper

  def full_title(page_name = "")
    base_title = "Muscle_App"
    if page_name.empty?
      base_title
    else
      page_name + " | " + base_title
    end
  end

  def color_for(part)
    case part
    when "胸"
      "#FFB6C1"  # ピンク
    when "背中"
      "#6495ED"  # ブルー
    when "腹筋"
      "#00FF7F"  # グリーン
    when "脚"
      "#FFA500"  # オレンジ
    when "上腕二頭筋"
      "#FF1493"  # フクシャ
    when "上腕三頭筋"
      "#008080"  # ティール
    when "肩"
      "#FFD700"  # ゴールド
    else
      "black"    # 黒
    end
  end
  
  
end