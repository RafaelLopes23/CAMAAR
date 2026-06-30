require "test_helper"

class ResponsesControllerTest < ActionDispatch::IntegrationTest
  setup do
    
    @form_response = responses(:one)

    
    @user = users(:one)
    post sessions_url, params: { email: @user.email, password: 'secret' }
  end

  test "should get index" do
    get responses_url
    assert_response :success
  end

  test "should get new" do
    get new_response_url
    assert_response :success
  end

  test "should create response" do
    assert_difference("Response.count") do
      post responses_url, params: { response: { content: @form_response.content, form_id: @form_response.form_id, user_id: @form_response.user_id } }
    end

    assert_redirected_to response_url(Response.last)
  end

  test "should show response" do
    
    get response_url(@form_response)
    assert_response :success
  end

  test "should get edit" do
   
    get edit_response_url(@form_response)
    assert_response :success
  end

  test "should update response" do
    patch response_url(@form_response), params: { response: { content: @form_response.content, form_id: @form_response.form_id, user_id: @form_response.user_id } }
    assert_redirected_to response_url(@form_response)
  end

  test "should destroy response" do
    assert_difference("Response.count", -1) do
      delete response_url(@form_response)
    end

    assert_redirected_to responses_url
  end
end