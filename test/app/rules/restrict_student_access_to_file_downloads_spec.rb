require_relative '../../minitest_helper'

describe "restrict student access to file downloads" do

  it "should be a Security Rule" do
    RestrictStudentAccessToFileDownloads.new.is_a?(SecurityRule).must_equal true
  end

  describe "preventing access for all students" do

    let(:rule) { RestrictStudentAccessToFileDownloads }

    describe "and the we are checking the rules for a User" do

      let(:subject) { Refinery::User.new }

      describe "and the user is not an admin" do

        before do
          subject.stubs(:some_sort_of_admin?).returns false
        end

        [Step, FileDownload].each do |thing|
          describe "and we are checking the rules of a #{thing}" do
            let(:target) { thing.new }

            describe "and the step does not have a tag for student_viewable" do
              before do
                target.stubs(:tags).returns [random_string, random_string, random_string]
              end

              it "should restrict the access to download the step pdf" do
                results = rule.prevented(subject, target)
                results.include?(:download_step_pdf).must_equal true
              end

              it "should restrict the view the file" do
                results = rule.prevented(subject, target)
                results.include?(:view_file).must_equal true
              end
            end

            describe "and the step does has a tag for student_viewable" do
              before do
                target.stubs(:tags).returns [random_string, 'student_viewable', random_string]
              end

              it "should not block anything" do
                results = rule.prevented(subject, target)
                results.count.must_equal 0
              end
            end

            describe "and the step does has a tag for Student Viewable" do
              before do
                target.stubs(:tags).returns [random_string, 'Student Viewable', random_string]
              end

              it "should not block anything" do
                results = rule.prevented(subject, target)
                results.count.must_equal 0
              end
            end
          end

          describe "and we are checking the rules of something that's not a #{thing}" do
            let(:target) { Object.new }

            it "should not prevent anything" do
              results = rule.prevented(subject, target)
              results.count.must_equal 0
            end
          end

        end

        describe "and the user is an admin" do

          before do
            subject.stubs(:some_sort_of_admin?).returns true
          end

          describe "and we are checking the rules of a Step" do
            let(:target) { Step.new }

            it "should not prevent anything" do
              results = rule.prevented(subject, target)
              results.count.must_equal 0
            end
          end

          describe "and we are checking the rules of something that's not a Step" do
            let(:target) { Object.new }

            it "should not prevent anything" do
              results = rule.prevented(subject, target)
              results.count.must_equal 0
            end
          end

        end

      end

    end

  end

end
