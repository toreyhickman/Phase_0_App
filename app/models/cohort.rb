class Cohort < ActiveRecord::Base
  before_save :year_first_in_name

  scope :not_started, -> { where("start_date > ?", Date.today) }
  scope :not_melt_or_hold, -> {where("name not like '%Melt%' and name not like '%Hold%'")}

  private
  def year_first_in_name
    self.name = self.name.sub(cohort_name_regex, '\3\2\1')
  end

  def cohort_name_regex
    /(\w+\s?\w+)(\s)(2014)/
  end
end
