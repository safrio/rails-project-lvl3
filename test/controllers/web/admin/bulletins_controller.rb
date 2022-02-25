# frozen_string_literal: true

require 'test_helper'

class Web::Admin::BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bulletin_attrs = {
      title: Faker::Job.title,
      description: Faker::Lorem.paragraph_by_chars(number: 150),
      category_id: categories(:one).id
    }

    @existed_draft_bulletin = bulletins(:one)
    @existed_under_moderation_bulletin = bulletins(:two)

    @image = fixture_file_upload(Rails.root.join('test/fixtures/files/test.jpg'), 'image/jpg')

    sign_in(users(:admin))
  end

  test 'should get index' do
    get admin_bulletins_url
    assert_response :success
  end

  test 'should get on_moderation' do
    get admin_root_url
    assert_response :success
  end

  test 'should publish bulletin' do
    patch publish_bulletin_url(@existed_draft_bulletin)

    @existed_draft_bulletin.reload

    assert { @existed_draft_bulletin.published? }
    assert_redirected_to profile_url
  end

  test 'should archive bulletin' do
    patch archive_admin_bulletin_url(@existed_draft_bulletin)

    @existed_draft_bulletin.reload

    assert { @existed_draft_bulletin.archived? }
    assert_redirected_to profile_url
  end

  test 'should reject bulletin' do
    patch reject_admin_bulletin_url(@existed_under_moderation_bulletin)

    @existed_under_moderation_bulletin.reload

    assert { @existed_under_moderation_bulletin.rejected? }
    assert_redirected_to profile_url
  end
end
