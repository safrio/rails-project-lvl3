# frozen_string_literal: true

require 'test_helper'

class Web::BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bulletin_attrs = {
      title: Faker::Job.title,
      description: Faker::Lorem.paragraph_by_chars(number: 150),
      category_id: categories(:one).id
    }

    @existed_bulletin = bulletins(:one)

    @image = fixture_file_upload(Rails.root.join('test/fixtures/files/test.jpg'), 'image/jpg')

    sign_in(users(:admin))
  end

  test 'should get index' do
    get root_url
    assert_response :success
  end

  test 'should get new' do
    get new_bulletin_url
    assert_response :success
  end

  test 'should create bulletin' do
    post bulletins_url, params: { bulletin: @bulletin_attrs.merge(image: @image) }

    assert { Bulletin.find_by! @bulletin_attrs.merge(user: current_user) }
    assert_redirected_to bulletin_url(Bulletin.last)
  end

  test 'should show bulletin' do
    get bulletin_url(@existed_bulletin)

    assert_response :success
  end

  test 'should get edit' do
    get edit_bulletin_url(@existed_bulletin)

    assert_response :success
  end

  test 'should update bulletin' do
    patch bulletin_url(@existed_bulletin), params: { bulletin: @bulletin_attrs.merge(image: @image) }

    assert { Bulletin.find_by! @bulletin_attrs.merge(user: current_user) }
    assert_redirected_to bulletin_url(@existed_bulletin)
  end

  test 'should moderate bulletin' do
    patch moderate_bulletin_url(@existed_bulletin)

    @existed_bulletin.reload

    assert { @existed_bulletin.under_moderation? }
    assert_redirected_to profile_url
  end

  test 'should archive bulletin' do
    patch archive_bulletin_url(@existed_bulletin)

    @existed_bulletin.reload

    assert { @existed_bulletin.archived? }
    assert_redirected_to profile_url
  end
end
