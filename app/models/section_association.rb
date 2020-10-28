class SectionAssociation < ApplicationRecord
  belongs_to :section_1, class_name: 'Section'
  belongs_to :section_2, class_name: 'Section'
end
