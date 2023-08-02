class StockpileMailer < ApplicationMailer
  def notice_mail(stockpile)
    user_email = stockpile.user.email
    @notice = stockpile.notice_on
    @name = stockpile.name
    mail to: user_email, subject: "消費期限確認のメール"
  end
end
