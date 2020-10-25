# frozen_string_literal: true

class FacultiesController < ApplicationController
  def index
    faculties = Faculty.all
    faculties = faculties.where(college_id: params[:college_id]) if params[:college_id]
    render json: faculties
  end

  def show
    faculty = Faculty.find_by_id(params[:id])
    render json: faculty
  end
end
