class SectionsController < ApplicationController
  def index
    sections = Section.all
    sections = sections.where(course_id: params[:course_id]) if params[:course_id]
    render json: sections
  end

  def show
    section = Section.find_by_id(params[:id])
    render json: section
  end
end
