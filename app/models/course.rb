class Course < ApplicationRecord
  belongs_to :faculty
  has_many :sections
end
