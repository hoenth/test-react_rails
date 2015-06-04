class Meetup < ActiveRecord::Base
  serialize :guests, JSON

  belongs_to :technology

  def guests=(guests)
    super(guests.select(&:present?).map(&:strip))
  end

end
