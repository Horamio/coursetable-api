# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

blocks_file = File.open(Rails.root.join('db', 'data', 'timeblocks.txt'))
courses_file = File.open(Rails.root.join('db', 'data', 'courses.txt'))

blocks_rows = blocks_file.readlines.map(&:chomp)
blocks_rows.shift
blocks_rows = blocks_rows.map { |row| row.split(/\t/) }

courses_rows = courses_file.readlines.map(&:chomp)
courses_rows.shift
courses_rows = courses_rows.map { |row| row.split(/\t/) }

college = College.create({ name: 'Universidad Nacional de Ingeniería' })
faculty = Faculty.create({ name: 'Facultad de Ingeniería Económica,Estadística y Ciencias Sociales', code: 'FIECS', college: college })
speciality = Speciality.create({ name: 'Ingeniería Económica', code: 'E6', faculty: faculty })

courses = []
courses_rows.each do |row|
  new_course = Course.create(
    { code: row[0],
      name: row[1],
      credits: row[2],
      semester: row[3] }
  )

  courses << new_course
  speciality.courses << new_course
end

courses.each do |course|
  course_blocks = blocks_rows.select { |row| row[0] == course.code }
  course_sections = course_blocks.map { |row| row[1] }.uniq
  sections = course_sections.map { |section_code| { course: course, code: section_code } }
  Section.create(sections)
end

blocks_rows.each do |block|
  course_code = block[0]
  section_code = block[1]

  course = Course.find_by({ code: course_code })
  section = Section.find_by({ code: section_code, course: course })

  day = block[2]
  session_type = block[3]

  professor = Professor.find_or_create_by({ name: block[5] })
  time_range = block[4].split('--')
  start_time = "#{time_range[0]}:00:00"
  end_time = "#{time_range[1]}:00:00"

  Timeblock.create(
    { professor: professor,
      place: Faker::Alphanumeric.alphanumeric(number: 4),
      start_time: start_time,
      end_time: end_time,
      session_type: session_type,
      day: day,
      section: section }
  )
end
