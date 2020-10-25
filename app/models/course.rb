class Course < ApplicationRecord
  has_and_belongs_to_many :specialities
  has_many :sections
end
