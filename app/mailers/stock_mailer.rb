class StockMailer < ApplicationMailer
  def stock_mail(user,total_required_rice)
    current_user = user
    @total_required_rice = total_required_rice

    mail to: current_user.email, subject: "必要物資量の確認メール"
  end
end
