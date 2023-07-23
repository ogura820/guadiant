class Family < ApplicationRecord
  enum sex: { 女性: 0, 男性: 1, その他:2, 回答しない: 3}
  enum diet: { しない: 0, 中食が多い: 1, する:2}

  belongs_to :user

  def icon_image
    if sex == "その他"
      'lgbt.png'
    elsif sex == "回答しない"
      'maruhi.png'
    elsif (0..6).include?(age)
      sex == "男性" ? 'baby_boy.png' : 'baby_girl.png'
    elsif (7..13).include?(age)
      sex == "男性" ? '7-13_man.png' : '7-13_woman.png'
    elsif (14..18).include?(age)
      sex == "男性" ? '14-18_man.png' : '14-18_woman.png'
    elsif (19..64).include?(age)
      sex == "男性" ? '19-64_man.png' : '19-64_woman.png'
    else
      sex == "男性" ? '64-man.png' : '64-woman.png'
    end
  end

  def calculate_required_quantity(material)
    case material
    when :water
       2
    when :rice
      sex_coefficient = case sex
                        when '男性' then 1.2
                        when '女性' then 0.8
                        else 1
                        end

      age_coefficient = case age
                        when 0..6 then 0.5
                        when 7..13 then 0.8
                        when 14..18 then 1.0
                        when 19..64 then 1.2
                        else 0.5
                        end

      2 * sex_coefficient * age_coefficient
    else
      raise ArgumentError, "Unknown material: #{material}"
    end
  end

end
