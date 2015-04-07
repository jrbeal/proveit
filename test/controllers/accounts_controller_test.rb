require 'test_helper'

class AccountsControllerTest < ActionController::TestCase
  setup do
    @account = accounts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:accounts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create account" do
    assert_difference('Account.count') do
      post :create, account: { about: @account.about, comments: @account.comments, default_filter: @account.default_filter, education: @account.education, email: @account.email, first_name: @account.first_name, initiators: @account.initiators, language: @account.language, last_name: @account.last_name, list: @account.list, location: @account.location, occupation: @account.occupation, offspring: @account.offspring, opinions: @account.opinions, password: @account.password, percentile: @account.percentile, phone: @account.phone, rating: @account.rating, timezone: @account.timezone, user_id: @account.user_id, user_name: @account.user_name, verbosity: @account.verbosity }
    end

    assert_redirected_to account_path(assigns(:account))
  end

  test "should show account" do
    get :show, id: @account
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @account
    assert_response :success
  end

  test "should update account" do
    patch :update, id: @account, account: { about: @account.about, comments: @account.comments, default_filter: @account.default_filter, education: @account.education, email: @account.email, first_name: @account.first_name, initiators: @account.initiators, language: @account.language, last_name: @account.last_name, list: @account.list, location: @account.location, occupation: @account.occupation, offspring: @account.offspring, opinions: @account.opinions, password: @account.password, percentile: @account.percentile, phone: @account.phone, rating: @account.rating, timezone: @account.timezone, user_id: @account.user_id, user_name: @account.user_name, verbosity: @account.verbosity }
    assert_redirected_to account_path(assigns(:account))
  end

  test "should destroy account" do
    assert_difference('Account.count', -1) do
      delete :destroy, id: @account
    end

    assert_redirected_to accounts_path
  end
end
