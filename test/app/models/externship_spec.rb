require_relative '../../minitest_helper'

describe Externship do

  describe "determining if campus/program combination requires externship" do

    let(:campus)  { Object.new }
    let(:program) { Object.new }

    it "should return true if the program is in the list of externship programs for a campus" do
      programs = [Object.new, program, Object.new].sort_by { |x| rand }
      Externship.stubs(:programs_for).with(campus).returns programs

      Externship.required_for?(campus, program).must_equal true
    end

    it "should return false if the program is NOT in the list of externship programs for a campus" do
      programs = [Object.new, Object.new, Object.new]
      Externship.stubs(:programs_for).with(campus).returns programs

      Externship.required_for?(campus, program).must_equal false
    end

  end

end
