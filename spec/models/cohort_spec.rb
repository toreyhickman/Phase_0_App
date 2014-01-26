require 'spec_helper'

describe Cohort do

  describe "associations" do
    it {should have_many(:students).class_name("User") }
  end

  describe "activerecord callbacks" do
    it "receives #year_first_in_name before save" do
      cohort = build(:cohort)
      cohort.should_receive(:year_first_in_name)
      cohort.save
    end
  end

  describe "#year_first_in_name" do
    it "works for cohort names with one word" do
      cohort = build(:cohort, name: "One 2014")
      cohort.send(:year_first_in_name)
      cohort.name.should eq "2014 One"
    end

    it "works for cohort names with two words" do
      cohort = build(:cohort, name: "One Two 2015")
      cohort.send(:year_first_in_name)
      cohort.name.should eq "2015 One Two"
    end

    it "works for cohort names with three words" do
      cohort = build(:cohort, name: "One Two Three 2016")
      cohort.send(:year_first_in_name)
      cohort.name.should eq "2016 One Two Three"
    end


  end

end
