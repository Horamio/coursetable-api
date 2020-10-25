class CoursesController < ApplicationController
  def index
    courses = Course.includes(specialities: { faculty: :college })

    courses = courses.where(colleges: { id: params[:college_id] }) if params[:college_id]
    courses = courses.where(faculties: { id: params[:faculty_id] }) if params[:faculty_id]
    courses = courses.where(specialities: { id: params[:speciality_id] }) if params[:speciality_id]
    courses = courses.where(semester: params[:semester]) if params[:semester]

    render json: courses
  end

  def show
    course = Course.find_by_id(params[:id])
    render json: course
  end
end
