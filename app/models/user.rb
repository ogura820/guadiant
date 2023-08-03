class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :maps
  has_many :families
  has_many :stockpiles

  def calculate_stocks
    {
      生米: {
              計算量: calculate_required_[:生米],
              一人分: basic_required_[:生米], 
              単位: unitary[:生米], 
              画像: 'stocks/food_kome_pack_big.png'
            },

      水: {
            計算量: calculate_required_[:水],
            一人分: basic_required_[:水], 
            単位: unitary[:水], 
            画像: 'stocks/bousai_water.png'
          },
          
      カセットボンベ: {
                      計算量: calculate_required_[:カセットボンベ], 
                      一人分: basic_required_[:カセットボンベ], 
                      単位: unitary[:カセットボンベ], 
                      画像: 'stocks/1201941.jpg'
                    },

      そうめん: {
                計算量: calculate_required_[:そうめん], 
                一人分: basic_required_[:そうめん], 
                単位: unitary[:そうめん], 
                画像: 'stocks/food_men_soumen.png'
              },

      パスタ: {
              計算量: calculate_required_[:パスタ], 
              一人分: basic_required_[:パスタ], 
              単位: unitary[:パスタ], 
              画像: 'stocks/964339.jpg'
            },

      パックごはん: {
                    計算量: calculate_required_[:パックごはん], 
                    一人分: basic_required_[:パックごはん], 
                    単位: unitary[:パックごはん], 
                    画像: 'stocks/pack_gohan_renji.png'
                  },

      カップ麺: {
                計算量: calculate_required_[:カップ麺], 
                一人分: basic_required_[:カップ麺], 
                単位: unitary[:カップ麺], 
                画像: 'stocks/food_cup_ra-men_close.png'
              },

      ご飯一緒に食べるレトルト食品: {
                                計算量: calculate_required_[:ご飯一緒に食べるレトルト食品], 
                                一人分: basic_required_[:ご飯一緒に食べるレトルト食品], 
                                単位: unitary[:ご飯一緒に食べるレトルト食品], 
                                画像: 'stocks/22732708.jpg'
                              },

      パスタと一緒に食べるレトルト食品: {
                                    計算量: calculate_required_[:パスタと一緒に食べるレトルト食品], 
                                    一人分: basic_required_[:パスタと一緒に食べるレトルト食品], 
                                    単位: unitary[:パスタと一緒に食べるレトルト食品], 
                                    画像: 'stocks/24003537.jpg'
                                  },

      缶詰: {
            計算量: calculate_required_[:缶詰], 
            一人分: basic_required_[:缶詰], 
            単位: unitary[:缶詰], 
            画像: 'stocks/food_kandume_saba.png'
          } 
    }
  end

private

  def basic_required_
    {
      生米: 2,
      水: 24,
      カセットボンベ: 6,
      そうめん: 150,
      パスタ: 300,
      パックごはん: 3,
      カップ麺: 3,
      ご飯一緒に食べるレトルト食品: 9,
      パスタと一緒に食べるレトルト食品: 3,
      缶詰: 9
    }
  end

  def unitary
    {
      生米: "kg",
      水: "ℓ",
      カセットボンベ: "個",
      そうめん: "g",
      パスタ: "g",
      パックごはん: "個",
      カップ麺: "個",
      ご飯一緒に食べるレトルト食品: "個",
      パスタと一緒に食べるレトルト食品: "個",
      缶詰: "個"
    }
  end

  def calculate_required_
    {
      生米: families.count * basic_required_[:生米],
      水: families.count * basic_required_[:水],
      カセットボンベ: families.count * basic_required_[:カセットボンベ],
      そうめん: families.count * basic_required_[:そうめん],
      パスタ: families.count * basic_required_[:パスタ],
      パックごはん: families.count * basic_required_[:パックごはん],
      カップ麺: families.count * basic_required_[:カップ麺],
      ご飯一緒に食べるレトルト食品: families.count * basic_required_[:ご飯一緒に食べるレトルト食品],
      パスタと一緒に食べるレトルト食品: families.count * basic_required_[:パスタと一緒に食べるレトルト食品],
      缶詰: families.count * basic_required_[:缶詰],
    }
  end 

end
