class StockMailer < ApplicationMailer
  def stock_mail(toral_stock,total_required_rice,user)
    current_user = user
    @total_required_rice = total_required_rice
    @required_stock = toral_stock
    mail to: current_user.email, subject: "必要物資量の確認メール"
  end
end
