require_relative '../../minitest_helper'

class TestOnlineOrCampusRules
  include OnlineOrCampusRule
end

describe OnlineOrCampusRule do
  it "should be an application modifier rule" do
    TestOnlineOrCampusRules.new.is_a?(ApplicationModifierRule).must_equal true
  end

  describe "run" do

    let(:lead)        { { 'data' => {} } }
    let(:application) { Struct.new(:steps).new steps }

    let(:steps) do
      [
        Struct.new(:tags, :status, :is_hidden).new([random_string, random_string, random_string], "", false),
        Struct.new(:tags, :status, :is_hidden).new(["Online Only", random_string, random_string], "", false),
        Struct.new(:tags, :status, :is_hidden).new([random_string, "Online Only", random_string], "", false),
        Struct.new(:tags, :status, :is_hidden).new([random_string, random_string, "Online Only"], "", false),
        Struct.new(:tags, :status, :is_hidden).new(["Ground Only", random_string, random_string], "", false),
        Struct.new(:tags, :status, :is_hidden).new([random_string, "Ground Only", random_string], "", false),
        Struct.new(:tags, :status, :is_hidden).new([random_string, random_string, "Ground Only"], "", false),
        Struct.new(:tags, :status, :is_hidden).new(["Campus Only", random_string, random_string], "", false),
        Struct.new(:tags, :status, :is_hidden).new([random_string, "Campus Only", random_string], "", false),
        Struct.new(:tags, :status, :is_hidden).new([random_string, random_string, "Campus Only"], "", false),
        Struct.new(:tags, :status, :is_hidden).new([random_string, random_string, random_string], "", false),
      ].sort_by { |x| random_string }
    end

    describe "an online campus is selected" do

      before do
        lead['data']['campus_of_interest'] = 'Online'
      end

      it "should complete the ground only steps steps" do
        OnlineOrCampusRule.run lead, application
        steps.select { |x| x.status == "Complete" && x.tags.include?("Ground Only") }.count.must_equal 3
      end

      it "should hidee the ground only steps" do
        OnlineOrCampusRule.run lead, application
        steps.select { |x| x.is_hidden && x.tags.include?("Ground Only") }.count.must_equal 3
      end

      it "should complete the campus only steps steps" do
        OnlineOrCampusRule.run lead, application
        steps.select { |x| x.status == "Complete" && x.tags.include?("Campus Only") }.count.must_equal 3
      end

      it "should hidee the campus only steps" do
        OnlineOrCampusRule.run lead, application
        steps.select { |x| x.is_hidden && x.tags.include?("Campus Only") }.count.must_equal 3
      end

    end

    describe "a ground campus is selected" do

      ['Rogers', 'Topeka', 'Springfield', 'Columbia', 'Broadcast Center'].each do |ground_campus|

        describe "#{ground_campus} campus" do

          before do
            lead['data']['campus_of_interest'] = ground_campus
          end

          it "should complete the online only steps" do
            OnlineOrCampusRule.run lead, application
            steps.select { |x| x.status == "Complete" && x.tags.include?("Online Only") }.count.must_equal 3
          end

          it "should hidee the online only steps" do
            OnlineOrCampusRule.run lead, application
            steps.select { |x| x.is_hidden && x.tags.include?("Online Only") }.count.must_equal 3
          end

        end

      end

    end

    describe "bad inputs" do
      it "should not throw an exception" do
        OnlineOrCampusRule.run nil,  application
        OnlineOrCampusRule.run({},   application)
        OnlineOrCampusRule.run lead, nil
      end
    end

  end

end
