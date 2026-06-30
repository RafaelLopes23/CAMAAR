require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do

    @user = users(:one)
  end

  test "should get new" do
    get new_session_url
    assert_response :success
  end

  test "should create session (login success)" do
    post sessions_url, params: { email: @user.email, password: 'secret' }
    assert_redirected_to new_import_path
    assert_equal "Login realizado com sucesso", flash[:notice]
  end

  test "should fail to create session with invalid credentials" do
    post sessions_url, params: { email: @user.email, password: 'senha_incorreta' }
    
    assert_response :unprocessable_entity
    assert_equal "Email ou senha inválidos", flash[:alert]
  end

  test "should destroy session (logout)" do
    post sessions_url, params: { email: @user.email, password: 'secret' }
    
    delete session_url(@user)
    
    assert_redirected_to new_session_path
    assert_equal "Logout realizado com sucesso", flash[:notice]
  end
end