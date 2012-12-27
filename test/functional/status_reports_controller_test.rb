require 'test_helper'

class StatusReportsControllerTest < ActionController::TestCase

  setup :login_as_deepakvig

  setup do
    @status_report = status_reports(:first)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:status_reports)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create status_report with data" do
    set_current_project(:gradschoolmatch)
    assert_difference('StatusReport.count', 1) do
      post :create, :status_report => { 
        :yesterday => 'I did stuff',
        :today => 'I will do stuff'
      }
    end

    actual = assigns(:status_report)
    assert_equal projects(:gradschoolmatch).id , actual.project.id
    assert_equal users(:deepakvig).id , actual.user.id
    assert_equal Date.today.to_s(:db) , actual.status_date.to_s(:db)
    assert_redirected_to status_report_path(actual)
  end

  test "redirect and logout if the user tries to snipe a user id" do
    someone = User.create!(:email => "someone@gmail.com", :password => "iiit123", :password_confirmation => "iiit123")
    set_current_project(:gradschoolmatch)
    assert_no_difference('StatusReport.count') do
      post :create, :status_report => {
        :user_id => someone.id,
        :yesterday => 'I did stuff',
        :today => 'I will do stuff'
      }
    end
    assert_nil session[:user_id]
    assert_redirected_to new_user_session_path
  end

  test "should show status_report" do
    get :show, id: @status_report
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @status_report
    assert_response :success
  end

  test "should update status_report" do
    put :update, id: @status_report, status_report: @status_report.attributes
    assert_redirected_to status_report_path(assigns(:status_report))
  end

  test "should destroy status_report" do
    assert_difference('StatusReport.count', -1) do
      delete :destroy, id: @status_report
    end

    assert_redirected_to status_reports_path
  end

  test "new form has expected elements" do
    get :new
    assert_select "form[id=new_status_report][action=/status_reports]" do
      assert_select "#status_report_project", :count => 0
      assert_select "#status_report_user", :count => 0
      assert_select "textarea#status_report_today"
      assert_select "textarea#status_report_yesterday"
      assert_select "#status_report_status_date_1i", :count => 0
    end
  end

end
