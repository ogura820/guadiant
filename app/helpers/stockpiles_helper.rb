module StockpilesHelper
  
  def stockpile_strftime_text(stockpile)
    if stockpile == nil 
      "指定なし" 
    else
      stockpile.strftime("%Y年%m月%d日") 
    end
  end

end
