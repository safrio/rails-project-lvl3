# frozen_string_literal: true

require 'test_helper'

class Web::Admin::CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category_attrs = {
      name: Faker::Job.title
    }

    @existed = categories(:one)

    sign_in(users(:admin))
  end

  test 'should get index' do
    get admin_categories_url
    assert_response :success
  end

  test 'should get new' do
    get new_admin_category_url
    assert_response :success
  end

  test 'should create category' do
    post admin_categories_url, params: { category: @category_attrs }

    assert { Category.find_by! @category_attrs }
    assert_redirected_to admin_categories_url
  end

  test 'should get edit' do
    get edit_admin_category_url(@existed)

    assert_response :success
  end

  test 'should update category' do
    patch admin_category_url(@existed), params: { category: @category_attrs }

    assert { Category.find_by! @category_attrs }
    assert_redirected_to admin_categories_url
  end

  test 'should destroy category' do
    delete admin_category_url(@existed)

    assert { !Category.find_by(id: @existed.id) }
    assert_redirected_to admin_categories_url
  end
end
