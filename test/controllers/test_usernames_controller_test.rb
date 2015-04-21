require 'test_helper'

class TestUsernamesControllerTest < ActionController::TestCase
  setup do
    @test_username = test_usernames(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:test_usernames)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create test_username" do
    assert_difference('TestUsername.count') do
      post :create, test_username: { description: @test_username.description, name: @test_username.name, picture: @test_username.picture }
    end

    assert_redirected_to test_username_path(assigns(:test_username))
  end

  test "should show test_username" do
    get :show, id: @test_username
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @test_username
    assert_response :success
  end

  test "should update test_username" do
    patch :update, id: @test_username, test_username: { description: @test_username.description, name: @test_username.name, picture: @test_username.picture }
    assert_redirected_to test_username_path(assigns(:test_username))
  end

  test "should destroy test_username" do
    assert_difference('TestUsername.count', -1) do
      delete :destroy, id: @test_username
    end

    assert_redirected_to test_usernames_path
  end
end
