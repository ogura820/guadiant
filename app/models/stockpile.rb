class Stockpile < ApplicationRecord
  belongs_to :user

  def self.notice_on_check
    Stockpile.all.each do |stockpile|
      if stockpile.notice_on && stockpile.notice_on.to_date < Time.now.to_date
        stockpile.status = true
        stockpile.save
      end
    end
    Rails.logger.info "Stockpile.notice_on_check executed at #{Time.now}"
  end

end
