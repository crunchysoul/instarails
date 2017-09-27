class Photo < ApplicationRecord
  include ImageUploader::Attachment.new(:image)

  # attr_accessor :raw_address

  belongs_to :user
  has_and_belongs_to_many :likers, class_name: 'User', join_table: :likes
  has_many :comments

  geocoded_by :location   # can also be an IP address
  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode
  after_validation :geocode, if: ->(obj){ obj.location.present? and obj.location_changed? }
  after_validation :reverse_geocode, unless: ->(obj) { obj.location.present? },
    if: ->(obj){ obj.latitude.present? and obj.latitude_changed? and obj.longitude.present? and obj.longitude_changed? }


  # group_photo.liked_by?(jo)
  def liked_by?(user)
    likers.exists?(user.id)
  end

  def toggle_liked_by(user)
    if likers.exists?(user.id)
      likers.destroy(user.id)
    else
      likers << user
    end
  end
end



# photo = Photo.first
# all_people_who_liked_that_photo = photo.likers
#
# other_person = User.second
# photo.likers << other_person
# photo.likers.destroy(other_person)
