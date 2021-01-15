class Sale < ActiveRecord::Base

  def self.active_sale
    where("sales.starts_on < ? AND sales.ends_on >= ?", Date.current, Date.current).first
  end

  def finished?
    ends_on < Date.current
  end

  def upcoming?
    starts_on > Date.current
  end

  def active?
    !upcoming? && !finished?
  end

end
