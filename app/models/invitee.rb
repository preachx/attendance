class Invitee < ActiveRecord::Base
  has_many :event_invitees
  has_many :events, through: :event_invitees
  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

  CATEGORIES = [:general, :vip, :vvip]

  validates_presence_of :name, :category
  validates_inclusion_of :category, :in => CATEGORIES.map {|x| x.to_s }

  def self.categories
    CATEGORIES
  end

end
