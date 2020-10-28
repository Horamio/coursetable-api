module SectionsHelper
  def total_iner_time(section_1, section_2)
    codeblocks_1 = section_1.timeblocks
    codeblocks_2 = section_2.timeblocks

    total_iner_time = 0

    codeblocks_1.each do |codeblock_1|
      codeblocks_2.each do |codeblock_2|
        next if codeblock_1.day != codeblock_2.day

        start_time_1 = codeblock_1.start_time
        start_time_2 = codeblock_2.start_time
        end_time_1 = codeblock_1.end_time
        end_time_2 = codeblock_2.end_time

        iner_start = [start_time_1, start_time_2].max
        iner_end = [end_time_1, end_time_2].min

        next if iner_start > iner_end

        total_iner_time += (iner_end - iner_start)
      end
    end

    total_iner_time /= 60
  end
end