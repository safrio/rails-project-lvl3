# frozen_string_literal: true

require 'test_helper'

class Web::Admin::BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @draft = bulletins(:draft)
    @under_moderation = bulletins(:under_moderation)

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
    patch publish_admin_bulletin_url(@under_moderation)

    @under_moderation.reload

    assert { @under_moderation.published? }
    assert_redirected_to admin_bulletins_url
  end

  test 'should archive bulletin' do
    patch archive_admin_bulletin_url(@draft)

    @draft.reload

    assert { @draft.archived? }
    assert_redirected_to admin_bulletins_url
  end

  test 'should reject bulletin' do
    patch reject_admin_bulletin_url(@under_moderation)

    @under_moderation.reload

    assert { @under_moderation.rejected? }
    assert_redirected_to admin_bulletins_url
  end
end
