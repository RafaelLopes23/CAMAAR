require "test_helper"

class ResponsesControllerTest < ActionDispatch::IntegrationTest
  setup do
    # MUDANÇA AQUI: Trocamos @response (reservado) por @form_response
    @form_response = responses(:one)

    # Mantemos o login para não batermos na barreira de segurança
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
    # Passando a variável renomeada
    get response_url(@form_response)
    assert_response :success
  end

  test "should get edit" do
    # Passando a variável renomeada
    get edit_response_url(@form_response)
    assert_response :success
  end

  test "should update response" do
    # Passando a variável renomeada
    patch response_url(@form_response), params: { response: { content: @form_response.content, form_id: @form_response.form_id, user_id: @form_response.user_id } }
    assert_redirected_to response_url(@form_response)
  end

  test "should destroy response" do
    assert_difference("Response.count", -1) do
      # Passando a variável renomeada
      delete response_url(@form_response)
    end

    assert_redirected_to responses_url
  end
end