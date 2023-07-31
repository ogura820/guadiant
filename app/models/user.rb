class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :maps
  has_many :families
  has_many :stockpiles

  def calculate_stocks
    stocks = {
              水: calculate_required_water,
              カセットボンベ: calculate_required_gas,
              そうめん: calculate_required_somen,
              パスタ: calculate_required_pasta,
              パックごはん: calculate_required_packed_cooked_rice,
              カップ麺: calculate_required_instant_noodles,
              ご飯一緒に食べるレトルト食品: calculate_required_retotr_rice_food,
              パスタと一緒に食べるレトルト食品: calculate_required_retotr_pasta_food,
              缶詰: calculate_required_tinned_food
              }
  end

private

  def calculate_required_water
    count = families.count * 24
    "#{count}ℓ"
  end 

  def calculate_required_gas
    count = families.count * 6
    "#{count}個"
  end 

  def calculate_required_somen
    count = families.count * 150
    "#{count}g"
  end 

  def calculate_required_pasta
    count = families.count * 300
    "#{count}g"
  end 

  def calculate_required_packed_cooked_rice
    count = families.count * 3
    "#{count}個"
  end 

  def calculate_required_instant_noodles
    count = families.count * 3
    "#{count}個"
  end 

  def calculate_required_retotr_rice_food
    count = families.count * 9
    "#{count}個"
  end 

  def calculate_required_retotr_pasta_food
    count = families.count * 3
    "#{count}個"
  end 

  def calculate_required_tinned_food
    count = families.count * 9
    "#{count}個"
  end 

end
