class Stockpile < ApplicationRecord
  belongs_to :user

  validates :name, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "expiry_on", "id", "name", "notice_on", "status", "updated_at"]
  end

  def self.notice_on_check
    Stockpile.all.each do |stockpile|
      if stockpile.notice_on && stockpile.notice_on.to_date < Time.now.to_date && stockpile.status = false
        stockpile.status = true
        StockpileMailer.notice_mail(stockpile).deliver
        stockpile.save
      end
    end
  end

end
