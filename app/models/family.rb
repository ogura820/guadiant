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

  def calculate_required_water
      user.families.count * 2
  end

end
