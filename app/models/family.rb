class Family < ApplicationRecord
  enum sex: { 男: 0, その他: 1, 女:2}
  enum diet: { 多め: 0, 普通: 1, 少なめ:2}
end
