class Invitee < ActiveRecord::Base
  has_many :event_invitees
  has_many :events, through: :event_invitees
  has_attached_file :photo, :styles => { :original => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.jpg"
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

  CATEGORIES = [:general, :vip, :vvip]

  validates_presence_of :name, :category
  validates_inclusion_of :category, :in => CATEGORIES.map {|x| x.to_s }

  def self.categories
    CATEGORIES
  end

  def photo_url
    photo.url(:original)
  end

  def number_of_people_invited(event_id)
    event_invitees.where(event_id: params[:event_id]).first.try(:number_of_people_invited) || 0
  end

  def number_of_people_brought
    event_invitees.where(event_id: params[:event_id]).first.try(:number_of_people_brought) || 0
  end
end
