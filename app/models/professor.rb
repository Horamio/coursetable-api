class Professor < ApplicationRecord
  has_and_belongs_to_many :faculties
end
