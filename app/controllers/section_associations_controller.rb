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

    course_1 = section_1.course
    course_2 = section_2.course

    iner_time = total_iner_time(section_1, section_2)

    section_association = SectionAssociation
                          .create_with({
                                         section_1: section_1,
                                         section_2: section_2,
                                         intersect: iner_time.positive?,
                                         intersect_minutes: iner_time,
                                         enabled: course_1 != course_2
                                       }).find_or_create_by({ section_1: section_1,
                                                              section_2: section_2 })

    render json: section_association
  end
end
