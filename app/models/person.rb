class Person < ApplicationRecord
    belongs_to :user
    has_many :items, dependent: :destroy
    has_one_attached :avatar
    has_many :reviews, :reports

    geocoded_by :address
    after_validation :geocode

    reverse_geocoded_by :latitude, :longitude
    after_validation :reverse_geocode

    validates :fname,:presence => true
    validates :lname, :presence => true
    validates :street,:presence => true
    validates :city, :presence => true
    validates :province,:presence => true
    validates :country, :presence => true

    def address
        [street, city, province, country].compact.join(', ')
    end
end
