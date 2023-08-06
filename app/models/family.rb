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

end
