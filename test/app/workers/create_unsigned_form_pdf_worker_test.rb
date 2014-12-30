require File.expand_path(File.dirname(__FILE__) + '/../../minitest_helper')

describe CreateUnsignedFormPdfWorker do

  let(:worker) { CreateUnsignedFormPdfWorker.new }

  describe "perform" do

    let(:pdf_url)  { Object.new }
    let(:pdf_path) { Object.new }

    let(:user_id)             { random_integer }
    let(:user_application_id) { random_integer }

    let(:user_application) { Struct.new(:user_id).new user_id }

    let(:data) do
      { 
        'pdf_url'             => pdf_url,
        'user_application_id' => user_application_id,
      }
    end

    before do
      FileUpload.delete_all
      worker.stubs(:write_the_file_to_s3_from_local_path)
      File.stubs(:basename).returns random_string
      PhantomjsPdfRetriever.stubs(:generate_pdf_for_url).with(pdf_url).returns pdf_path
      UserApplication.stubs(:find).with(user_application_id).returns user_application
    end

    it "should write the file to s3 from the local path" do
      worker.expects(:write_the_file_to_s3_from_local_path).with pdf_path
      worker.perform data
    end

    describe "creating a new file upload" do
      it "should create a new file upload" do
        worker.perform data
        FileUpload.count.must_equal 1
      end

      it "should set the user application id" do
        worker.perform data
        FileUpload.first.user_application_id.must_equal user_application_id
      end

      it "should set the user id" do
        worker.perform data
        FileUpload.first.user_id.must_equal user_id
      end

      it "should set the name" do
        worker.perform data
        FileUpload.first.name.must_equal 'Updated Award Letter'
      end

      it "should set the basename of the pdf path" do
        basename = random_string
        File.stubs(:basename).with(pdf_path).returns basename
        worker.perform data
        FileUpload.first.filepicker_data['key'].must_equal basename
      end

      it "use the save method that will throw if the file upload could not be saved" do
        FileUpload.any_instance.expects(:save).never
        FileUpload.any_instance.expects(:save!)
        worker.perform data
      end

      describe 'notifications' do

        describe 'notification exists' do

          it 'should send a notification to the user' do
            NotificationSender.expects(:send_notification).with do |n, data|
              name = "#{user.first_name} #{user.last_name}"
              data[:email].must_equal user.email
              data[:student_name].must_equal name
              notification.to_recipient_blocks.first[:email].must_equal user.email
              notification.to_recipient_blocks.first[:name].must_equal name
              true
            end

            worker.perform data
          end

          it 'should not send a notification if the user does not exist' do
            Refinery::User.stubs(:where).returns []

            NotificationSender.expects(:send_notification).never

            worker.perform data
          end

          before do
            NotificationProvider.stubs(:get_notification_by_tag).with('Award Letter Generated').returns notification
          end

        end

        describe 'notification does not exist' do

          it 'should not send a notification' do
            NotificationSender.expects(:send_notification).never

            worker.perform data
          end

          before do
            NotificationProvider.stubs(:get_notification_by_tag).with('Award Letter Generated').returns nil
          end

        end

        before do
          UserApplication.stubs(:where).with({ id: user_application_id }).returns [user_application]
          Refinery::User.stubs(:where).with({ id: user.id }).returns [user]
        end

        let(:user_application) do
          ua = UserApplication.new
          ua.id = user_application_id
          ua.user_id = user.id
          ua
        end

        let(:user) do
          u = Refinery::User.new
          u.id         = rand(999999)
          u.email      = "user#{rand(9999)}@test.net"
          u.first_name = 'first name'
          u.last_name  = 'last name'
          u
        end

        let(:notification) do
          Notification.new
        end

      end

    end

  end

end
