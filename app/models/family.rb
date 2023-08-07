class Family < ApplicationRecord
  enum sex: { 女性: 0, 男性: 1, その他:2, 回答しない: 3 }
  enum diet: { しない: 0, 中食が多い: 1, する:2 }

  belongs_to :user

  def self.increase_age
    Family.where("age <= ?", 130).update_all("age = age + 1")
  end  

  def icon_image
    if sex == "その他"
      'lgbt.png'
    elsif sex == "回答しない"
      'maruhi.png'
    elsif (0..6).include?(age)
      sex == "男性" ? 'age/baby_boy.png' : 'age/baby_girl.png'
    elsif (7..13).include?(age)
      sex == "男性" ? 'age/7-13_man.png' : 'age/7-13_woman.png'
    elsif (14..18).include?(age)
      sex == "男性" ? 'age/14-18_man.png' : 'age/14-18_woman.png'
    elsif (19..64).include?(age)
      sex == "男性" ? 'age/19-64_man.png' : 'age/19-64_woman.png'
    else
      sex == "男性" ? 'age/64-man.png' : 'age/64-woman.png'
    end
  end

  def coefficient
    age_coefficient = 0

    case age
    when 0..6
      age_coefficient += 0.6
    when 7..13
      age_coefficient += 0.8
    when 14..18
      age_coefficient += 1.2
    else
      age_coefficient += 1.0
    end
    age_coefficient
  end

    def self.generate_story(current_user)
    client = OpenAI::Client.new(access_token: ENV["CHATGPT_API_KEY"])

    family_info = current_user.families.map do |f|
            {
              name: f.name,
              sex: f.sex,
              age: f.age,
              diet: f.diet
            }
    end

    stocks_info = current_user.calculate_stocks

    # family_info と stocks_info の情報を組み合わせてメッセージの content を生成
    content = "可能な限りメンバーの性別と年齢を考慮してください."
    family_info.each do |info|
      content += "メンバーは#{info[:name]}さんは#{info[:age]}歳の#{info[:sex]}で、食生活は#{info[:diet]}です。"
    end
  
    content += "防災備蓄として以下の物資を保有しています："
    stocks_info.each do |item, data|
      content += "【#{item}】  一人分: #{data[:一人分]}。"
    end

    content += "他に必要な物資を教えてください。保有している物資については回答に含めないでください。出力は、(物資名)：(簡単な理由)で3個書いてください。。"
    response = client.chat(
      parameters: {
                    model: 'gpt-3.5-turbo',
                    messages: [{ role: 'user',content: "#{content}" }],
      }
    )
    response.dig('choices', 0, 'message', 'content')
  end

end
