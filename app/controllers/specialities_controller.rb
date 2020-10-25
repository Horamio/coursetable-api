# frozen_string_literal: true

class SpecialitiesController < ApplicationController
  def index
    specialities = Speciality.includes(faculty: :college)
    specialities = specialities.where(faculty_id: params[:faculty_id]) if params[:faculty_id]
    specialities = specialities.where(colleges: { id: params[:college_id] }) if params[:college_id]
    render json: specialities
  end

  def show
    speciality = Speciality.find_by_id(params[:id])
    render json: speciality
  end
end
