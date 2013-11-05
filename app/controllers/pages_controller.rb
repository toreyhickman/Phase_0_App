class PagesController < ApplicationController

  def welcome
    @cohorts = year_first(cohorts_in_phase_0)
  end

  private
  def cohorts_in_phase_0
    DBC::Cohort.all.select { |c| c.in_session == false && c.name.match(/2014/) && !c.name.match(/Melt/) }
  end

  def year_first(cohorts_array)
    cohorts = cohorts_array.each do |c|
      puts c.name
      c.instance_variable_set(:@name, c.name.sub(cohort_name_regex, '\3 \2 \1'))
    end
    cohorts
  end

  def cohort_name_regex
    /(\w+\s?\w+)(\s)(2014)/
  end

end
