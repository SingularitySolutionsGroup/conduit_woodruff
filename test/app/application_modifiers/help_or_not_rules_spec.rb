require_relative '../../minitest_helper'

class TestHelpOrNotRules
  include HelpOrNotRules
end

describe HelpOrNotRules do

  it "should be an ApplicationModifierRule" do
    TestHelpOrNotRules.new.is_a?(ApplicationModifierRule).must_equal true
  end

  describe "run" do

    let(:lead)        { {} }
    let(:application) { Struct.new(:steps).new steps }

    let(:steps) do
      [
        Struct.new(:tags, :status, :is_hidden).new([random_string,  random_string,  random_string ], "", false),
        Struct.new(:tags, :status, :is_hidden).new([random_string,  random_string,  HelpOrNotRules::HELP_ONLY_TAGS[0]   ], "", false),
        Struct.new(:tags, :status, :is_hidden).new([HelpOrNotRules::HELP_ONLY_TAGS[0],    random_string,  random_string ], "", false),
        Struct.new(:tags, :status, :is_hidden).new([random_string,  random_string,  HelpOrNotRules::NO_HELP_ONLY_TAGS[0]], "", false),
        Struct.new(:tags, :status, :is_hidden).new([random_string,  HelpOrNotRules::HELP_ONLY_TAGS[0],    random_string ], "", false),
        Struct.new(:tags, :status, :is_hidden).new([HelpOrNotRules::NO_HELP_ONLY_TAGS[0], random_string,  random_string ], "", false),
        Struct.new(:tags, :status, :is_hidden).new([random_string,  HelpOrNotRules::NO_HELP_ONLY_TAGS[0], random_string ], "", false),

        Struct.new(:tags, :status, :is_hidden).new([random_string,  random_string,  HelpOrNotRules::HELP_ONLY_TAGS[1]   ], "", false),
        Struct.new(:tags, :status, :is_hidden).new([HelpOrNotRules::HELP_ONLY_TAGS[1],    random_string,  random_string ], "", false),
        Struct.new(:tags, :status, :is_hidden).new([random_string,  random_string,  HelpOrNotRules::NO_HELP_ONLY_TAGS[1]], "", false),
        Struct.new(:tags, :status, :is_hidden).new([random_string,  HelpOrNotRules::HELP_ONLY_TAGS[1],    random_string ], "", false),
        Struct.new(:tags, :status, :is_hidden).new([HelpOrNotRules::NO_HELP_ONLY_TAGS[1], random_string,  random_string ], "", false),
        Struct.new(:tags, :status, :is_hidden).new([random_string,  HelpOrNotRules::NO_HELP_ONLY_TAGS[1], random_string ], "", false),

        Struct.new(:tags, :status, :is_hidden).new([random_string,  random_string,  random_string ], "", false),
      ].sort_by { |x| random_string }
    end

    describe "bad inputs" do
      it "should not throw an error if missing a lead" do
        HelpOrNotRules.run nil, application
      end
      it "should not throw an error if missing a lead" do
        HelpOrNotRules.run lead, nil
      end
    end

    HelpOrNotRules::NO_HELP_ONLY_TAGS.each do |tag|
      describe "when the user wants help" do

        [true, 'Yes', 'yes', '(+)', 'something (+) slkdjf'].each do |way_to_say_you_want_help|

          describe "different locations to store the data" do
            [1, 2].each do |depth|
              describe "multiple ways to say you want help" do

                before do
                  if depth == 1
                    lead[HelpOrNotRules::HELP_WANTED_FIELD] = way_to_say_you_want_help
                  else
                    lead['data'] = {}
                    lead['data'][HelpOrNotRules::HELP_WANTED_FIELD] = way_to_say_you_want_help
                  end
                end

                it "should hide the steps that are for No Help Only" do
                  HelpOrNotRules.run lead, application
                  steps.select { |x| x.is_hidden }.count.must_equal 6
                  steps.reject { |x| x.is_hidden }.map { |x| x.tags }.flatten.select { |x| x == tag }.count.must_equal 0
                end

                it "should complete the steps that are for No Help Only" do
                  HelpOrNotRules.run lead, application
                  steps.select { |x| x.status == "Complete" }.count.must_equal 6
                  steps.reject { |x| x.status == "Complete" }.map { |x| x.tags }.flatten.select { |x| x == tag }.count.must_equal 0
                end

              end
            end
          end

        end

      end

    end

    HelpOrNotRules::HELP_ONLY_TAGS.each do |tag|
      describe "when the user does not want help" do

        [false, nil, 'No', 'no'].each do |wants_help|

          describe "the many ways to say they do not want help" do

            [1, 2].each do |depth|
              describe "multiple ways to say you want help" do

                before do
                  if depth == 1
                    lead[HelpOrNotRules::HELP_WANTED_FIELD] = wants_help
                  else
                    lead['data'] = {}
                    lead['data'][HelpOrNotRules::HELP_WANTED_FIELD] = wants_help
                  end
                end

                it "should hide the steps that are for Help Only" do
                  HelpOrNotRules.run lead, application
                  steps.select { |x| x.is_hidden }.count.must_equal 6
                  steps.reject { |x| x.is_hidden }.map { |x| x.tags }.flatten.select { |x| x == tag }.count.must_equal 0
                end
              end
            end
          end
        end
      end
    end
  end

end
