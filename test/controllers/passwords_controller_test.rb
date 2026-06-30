require "test_helper"

class PasswordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    # Resgata o usuário da sua fixture padrão
    @user = users(:one)
  end

  test "should get edit" do
    # Passamos o 'user_id' como parâmetro para que o 'User.find' do controller 
    # consiga encontrar o usuário e carregar a página com sucesso!
    get edit_password_url(user_id: @user.id)
    
    assert_response :success
  end

  test "should update password" do
    # 1. Mudamos de 'get' para 'patch' (método correto de atualização)
    # 2. Corrigimos o helper para 'password_url' passando o 'user_id'
    # 3. Enviamos os parâmetros de senha com no mínimo 8 caracteres (regra do seu controller)
    patch password_url(user_id: @user.id), params: {
      password: "nova_senha_123",
      password_confirmation: "nova_senha_123"
    }
    
    # Como a sua função 'activate_user_and_redirect' redireciona para a tela de login:
    assert_redirected_to new_session_path
    
    # Opcional: Garante que o status do usuário mudou para 'ativo' no banco
    @user.reload
    assert_equal "ativo", @user.status
  end
# Teste de falha: Senha muito curta (menos de 8 caracteres)
  test "should not update password if too short" do
    patch password_url(user_id: @user.id), params: { 
      password: "123", 
      password_confirmation: "123" 
    }
    
    assert_response :unprocessable_entity
    assert_equal "A senha deve conter no mínimo 8 caracteres e coincidir com a confirmação", flash.now[:alert]
    
    # Verifica que o status não foi alterado para 'ativo'
    @user.reload
    assert_not_equal "ativo", @user.status
  end

  # Teste de falha: Senhas não coincidem
  test "should not update password if confirmation does not match" do
    patch password_url(user_id: @user.id), params: { 
      password: "nova_senha_valida", 
      password_confirmation: "senha_diferente" 
    }
    
    assert_response :unprocessable_entity
    assert_equal "A senha deve conter no mínimo 8 caracteres e coincidir com a confirmação", flash.now[:alert]
  end
  
end  