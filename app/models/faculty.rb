class Faculty < ApplicationRecord
  belongs_to :college
  has_and_belongs_to_many :professors
end
