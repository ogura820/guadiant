User.create!(email: "admin@sample.com", password:"adminn", admin: true)
User.create!(email: "oda.nobunaga@sample.com", password:"oda.nobunaga")
User.create!(email: "toyotomi.hideyosi@sample.com", password:"toyotomi.hideyosi")
User.create!(email: "tokugawa.ieyasu@sample.com", password:"tokugawa.ieyasu")
User.create!(email: "houzyo.uziyasu@sample.com", password:"houzyo.uziyasu")

User.all.each do |user|
  user.families.create!(name: "父（サンプル）",
                sex:1,
                age:30,
                diet:0
                )
  user.families.create!(name: "母（サンプル）",
                sex:0,
                age:30,
                diet:0
                )
  user.families.create!(name: "長男（サンプル）",
                sex:1,
                age:10,
                diet:0
                )
  user.families.create!(name: "長女（サンプル）",
                sex:1,
                age:4,
                diet:0
                )
  user.families.create!(name: "ポチ（サンプル）",
                sex:1,
                age:3,
                diet:0,
                pet:true
                )

  user.stockpiles.create!(name: "生米")
  user.stockpiles.create!(name: "水")
  user.stockpiles.create!(name: "カセットボンベ")
  user.stockpiles.create!(name: "そうめん")
  user.stockpiles.create!(name: "パスタ")
  user.stockpiles.create!(name: "パックごはん")
  user.stockpiles.create!(name: "カップ麺")
  user.stockpiles.create!(name: "ご飯一緒に食べるレトルト食品")
  user.stockpiles.create!(name: "パスタと一緒に食べるレトルト食品")
  user.stockpiles.create!(name: "缶詰")

  user.maps.create!(name: "東京都（サンプル）",
                    latitude:35.68735,
                    longitude:139.741509,
                )
  user.maps.create!(name: "埼玉県（サンプル）",
                    latitude:35.862608,
                    longitude:139.652427,
                )
  user.maps.create!(name: "北海道（サンプル）",
                    latitude:43.065518,
                    longitude:141.337105,
                )
  user.maps.create!(name: "大阪市（サンプル）",
                    latitude:34.691412,
                    longitude:135.531221,
                )
  user.maps.create!(name: "福岡市中央区天神（サンプル）",
                    latitude:33.590878,
                    longitude:130.401396,
                )
end