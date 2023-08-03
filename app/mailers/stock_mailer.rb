class StockMailer < ApplicationMailer
  def stock_mail(toral_stock,coefficient,user)
    current_user = user
    @coefficient = coefficient
    @required_stock = toral_stock
    mail to: current_user.email, subject: "必要物資量の確認メール"
  end
end
