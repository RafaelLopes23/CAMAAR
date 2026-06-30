require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    # Carrega o usuário da fixture para os testes
    @user = users(:one)
  end

  test "should get new" do
    get new_session_url
    assert_response :success
  end

  test "should create session (login success)" do
    # Envia credenciais válidas
    post sessions_url, params: { email: @user.email, password: 'secret' }
    
    # Valida o redirecionamento e a mensagem exata do seu controller
    assert_redirected_to new_import_path
    assert_equal "Login realizado com sucesso", flash[:notice]
  end

  test "should fail to create session with invalid credentials" do
    # Envia uma senha errada de propósito
    post sessions_url, params: { email: @user.email, password: 'senha_incorreta' }
    
    # O controller deve barrar e retornar o status 422
    assert_response :unprocessable_entity
    assert_equal "Email ou senha inválidos", flash[:alert]
  end

  test "should destroy session (logout)" do
    # Primeiro fazemos o login para ter o que destruir
    post sessions_url, params: { email: @user.email, password: 'secret' }
    
    # Faz o logout. 
    # NOTA: O plural de resources exige um ID na rota de delete.
    delete session_url(@user)
    
    # Valida o redirecionamento e a mensagem de saída
    assert_redirected_to new_session_path
    assert_equal "Logout realizado com sucesso", flash[:notice]
  end
end