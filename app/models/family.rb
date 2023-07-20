class Family < ApplicationRecord
  enum sex: { 女性: 0, 男性: 1, その他:2, 回答しない: 3}
  enum diet: { 少なめ: 0, 普通: 1, 多め:2}
end
