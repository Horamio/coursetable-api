# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

college = College.create({ name: 'Universidad Nacional de Ingeniería' })

faculties = []
faculties << Faculty.create({ name: 'Ingeniería Económica', code: 'E5', college: college })
faculties << Faculty.create({ name: 'Ingeniería Estadística', code: 'E6', college: college })

courses = []
10.times do |_i|
  courses << Course.create(
    { name: Faker::Beer.unique.brand,
      code: Faker::Code.unique.asin,
      semester: rand(1..10),
      credits: rand(1..5),
      faculty: faculties.sample }
  )
end

sections = []
courses.each do |course|
  course.sections << Section.create({ code: 'A' })
  course.sections << Section.create({ code: 'B' })
  course.sections << Section.create({ code: 'C' })

  sections += course.sections
end

professors = []
20.times do |_i|
  professors << Professor.create({ name: Faker::Name.unique.name, code: Faker::Code.unique.asin })
end

days = %w[SU MO TU WE TH FR SA]
session_types = %w[P T L]

sections.each do |section|
  professors.each do |professor|
    Timeblock.create(
      { professor: professor,
        place: Faker::Alphanumeric.alphanumeric(number: 4),
        start_time: '09:00:00',
        end_time: '10:00:00',
        session_type: session_types.sample,
        day: days.sample,
        section: section }
    )
  end
end
