# frozen_string_literal: true

class Section < ApplicationRecord
  belongs_to :course
  has_many :timeblocks
  has_many :section_1_associations, foreign_key: :section_1_id,
                                    class_name: 'SectionAssociation'
  has_many :section_1s, through: :section_1_associations,
                        source: :section_2
  has_many :section_2_associations, foreign_key: :section_2_id,
                                    class_name: 'SectionAssociation'
  has_many :section_2s, through: :section_2_associations,
                        source: :section_1

  def associations
    (section_1s + section_2s).flatten.uniq
  end
end
