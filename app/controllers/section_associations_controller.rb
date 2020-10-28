# frozen_string_literal: true

include SectionsHelper

class SectionAssociationsController < ApplicationController
  def index
    section_association = SectionAssociation.all
    render json: section_association
  end

  def show
    section_association = SectionAssociation.find_by_id(params[:id])
    render json: section_association
  end

  def evaluate
    return render(json: { message: 'Missing section_1_id' }, status: 400)  unless params[:section_1_id]
    return render(json: { message: 'Missing section_2_id' }, status: 400)  unless params[:section_2_id]

    section_ids = [params[:section_1_id], params[:section_2_id]]
    section_1_id = section_ids.min
    section_2_id = section_ids.max
    section_1 = Section.find(section_1_id)
    section_2 = Section.find(section_2_id)

    section_association = evaluate_sections(section_1, section_2)

    render json: section_association
  end

  def evaluate_all
    sections = Section.all.order(:id)
    sections_count = sections.count
    sections.each.with_index do |section_1, index|
      break if (sections_count - 1) == index

      ((index + 1)..(sections_count - 1)).each do |section_2_index|
        section_2 = sections[section_2_index]
        evaluate_sections(section_1, section_2)
      end
    end
  end

  private

  def evaluate_sections(section_1, section_2)
    course_1 = section_1.course
    course_2 = section_2.course

    iner_time = total_iner_time(section_1, section_2)

    SectionAssociation
      .create_with({
                     section_1: section_1,
                     section_2: section_2,
                     intersect: iner_time.positive?,
                     intersect_minutes: iner_time,
                     enabled: course_1 != course_2
                   }).find_or_create_by({ section_1: section_1,
                                          section_2: section_2 })
  end
end
