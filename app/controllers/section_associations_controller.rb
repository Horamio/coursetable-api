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

  def generate_schedules
    courses_param = params[:courses]
    pp 'GAAAAAAA' * 100
    pp courses_param
    pp params[:a]
    pp 'GAAAAAAA' * 100

    goal_k = 5
    section_association = SectionAssociation.where({ enabled: true, intersect: false })

    graph = section_association.map { |assc| [assc.section_1_id, assc.section_2_id] }
    nodes = graph.flatten.uniq.sort

    binary_path = Rails.root.join('app', 'controllers', 'binaries', 'qc')
    inline_input = ''
    inline_input += "#{graph.flatten.max}\n"
    inline_input += "#{2 * graph.length}\n"

    graph.each do |edge|
      node0 = nodes.index(edge[0])
      node1 = nodes.index(edge[1])

      inline_input += "#{node0},#{node1}\n"
      inline_input += "#{node1},#{node0}\n"
    end

    cliques = `#{binary_path} --inline-input=\"#{inline_input}\" --algorithm=tomita`
    cliques = cliques.split("\n")
    cliques.shift
    cliques.map! do |clique|
      clique_arr = clique.split
      clique_arr.map { |ci| nodes[ci.to_i] }
    end

    render json: cliques
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
