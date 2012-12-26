require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase

  setup :login_as_deepakvig

  setup do
    @project = projects(:gradschoolmatch)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:projects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create project with data" do
    assert_difference('Project.count') do
      post :create, project: @project.attributes
    end

    assert_redirected_to project_path(assigns(:project))
  end

  test "should show project" do
    get :show, id: @project
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @project
    assert_response :success
  end

  test "should update project" do
    put :update, id: @project, project: @project.attributes
    assert_redirected_to project_path(assigns(:project))
  end

  test "should destroy project" do
    assert_difference('Project.count', -1) do
      delete :destroy, id: @project
    end

    assert_redirected_to projects_path
  end

  test "project timeline index should be sorted correctly" do
    set_current_project(:gradschoolmatch)
    get :show, :id => projects(:gradschoolmatch).to_param
    expected_keys = assigns(:reports).keys.sort.map{|d| d.to_s(:db)}
    assert_equal ["2011-07-01","2011-07-05"], expected_keys
    assert_equal [status_reports(:first).id] , assigns(:reports)[Date.parse("2011-07-01")].map(&:id)
  end

  test "index should display project timeline" do
    set_current_project(:gradschoolmatch)
    get :show, :id => projects(:gradschoolmatch).id
    assert_select "div[id *= day]", :count => 2
    assert_select "div#2011-07-01_day" do
      assert_select "div[id *= report]", :count => 1
      assert_select "div#?", dom_id(status_reports(:first))
    end
    assert_select "div#2011-07-05_day" do
      assert_select "div[id *= report]", :count => 1
      assert_select "div#?", dom_id(status_reports(:second))
    end
  end
end
