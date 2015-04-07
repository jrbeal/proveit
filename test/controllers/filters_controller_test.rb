require 'test_helper'

class FiltersControllerTest < ActionController::TestCase
  setup do
    @filter = filters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:filters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create filter" do
    assert_difference('Filter.count') do
      post :create, filter: { active: @filter.active, bookmarks: @filter.bookmarks, categories: @filter.categories, comments: @filter.comments, contested_objections: @filter.contested_objections, contested_opinions: @filter.contested_opinions, following: @filter.following, hot_topics: @filter.hot_topics, initiators: @filter.initiators, key_words: @filter.key_words, last_month: @filter.last_month, last_week: @filter.last_week, levels: @filter.levels, name: @filter.name, range: @filter.range, today: @filter.today, uncontested_objections: @filter.uncontested_objections, uncontested_opinions: @filter.uncontested_opinions }
    end

    assert_redirected_to filter_path(assigns(:filter))
  end

  test "should show filter" do
    get :show, id: @filter
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @filter
    assert_response :success
  end

  test "should update filter" do
    patch :update, id: @filter, filter: { active: @filter.active, bookmarks: @filter.bookmarks, categories: @filter.categories, comments: @filter.comments, contested_objections: @filter.contested_objections, contested_opinions: @filter.contested_opinions, following: @filter.following, hot_topics: @filter.hot_topics, initiators: @filter.initiators, key_words: @filter.key_words, last_month: @filter.last_month, last_week: @filter.last_week, levels: @filter.levels, name: @filter.name, range: @filter.range, today: @filter.today, uncontested_objections: @filter.uncontested_objections, uncontested_opinions: @filter.uncontested_opinions }
    assert_redirected_to filter_path(assigns(:filter))
  end

  test "should destroy filter" do
    assert_difference('Filter.count', -1) do
      delete :destroy, id: @filter
    end

    assert_redirected_to filters_path
  end
end
