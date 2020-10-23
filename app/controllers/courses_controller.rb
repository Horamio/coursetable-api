class CoursesController < ApplicationController
  def index
    render json: Course.all
  end

  def show
    course = Course.find_by_id(params[:id])
    render json: course
  end
end
