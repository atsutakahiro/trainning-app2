class LineBotController < ApplicationController
  require_dependency "user"
  require_dependency "train"
  require 'net/http'
  require 'uri'
  
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token
 


  def callback
    body = request.body.read
    events = client.parse_events_from(body)
  
    events.each { |event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          message_text = event.message['text']
          line_user_id = event['source']['userId']
  
          # line_user_idのログ出力
          Rails.logger.info "LINE User ID: #{line_user_id}"
  
          training_data = parse_training_message(message_text)
  
          if training_data.present?
            response_message = save_training_data(training_data, line_user_id)
          else
            response_message = "メッセージの形式が正しくありません。正しい形式で入力してください。"
          end
  
          message = {
            type: 'text',
            text: response_message
          }
          client.reply_message(event['replyToken'], message)
        end
      end
    }
  
    head :ok
  end
  

  private

  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end

  def parse_training_message(message_text)
    # 正規表現で入力文字列をパースします
    # 例: 胸, ベンチプレス, 100kg, 3, ギリギリ
    pattern = /^(.+),\s*(.+),\s*(\d+(?:\.\d+)?)(?:kg)?,\s*(\d+),\s*(.+)$/i
    matches = pattern.match(message_text)
  
    if matches
      {
        part: matches[1].strip,
        exercise: matches[2].strip,
        weight: matches[3].to_f,
        rep: matches[4].to_i,
        note: matches[5].strip
      }
    else
      nil
    end
  end
  
  def save_training_data(training_data, line_user_id)
    # ここでデータベースにトレーニングデータを保存します
    # 実際のアプリケーションでは適切なユーザーIDを取得して使用してください
    user = User.find_by(line_user_id: line_user_id)
  
    if user
      train = Train.new(
        user_id: user.id,
        part: training_data[:part],
        exercise: training_data[:exercise],
        weight: training_data[:weight],
        rep: training_data[:rep],
        note: training_data[:note],
        created_at: Time.now,
        updated_at: Time.now
      )
  
      if train.save
        "トレーニングデータを保存しました"
      else
        "トレーニングデータの保存に失敗しました"
      end
    else
      "ユーザーが見つかりませんでした"
    end
  end
end
