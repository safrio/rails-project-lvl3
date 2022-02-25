# frozen_string_literal: true

require 'test_helper'

class Web::ProfileControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in(users(:admin))
  end

  test 'should get index' do
    get profile_url
    assert_response :success
  end
end
