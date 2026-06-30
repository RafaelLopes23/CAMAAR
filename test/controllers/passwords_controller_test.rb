require "test_helper"

class PasswordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    
    @user = users(:one)
  end

  test "should get edit" do
   
    get edit_password_url(user_id: @user.id)
    
    assert_response :success
  end

  test "should update password" do
    
    patch password_url(user_id: @user.id), params: {
      password: "nova_senha_123",
      password_confirmation: "nova_senha_123"
    }
    
   
    assert_redirected_to new_session_path
    
   
    @user.reload
    assert_equal "ativo", @user.status
  end

  test "should not update password if too short" do
    patch password_url(user_id: @user.id), params: { 
      password: "123", 
      password_confirmation: "123" 
    }
    
    assert_response :unprocessable_entity
    assert_equal "A senha deve conter no mínimo 8 caracteres e coincidir com a confirmação", flash.now[:alert]
    

    @user.reload
    assert_not_equal "ativo", @user.status
  end


  test "should not update password if confirmation does not match" do
    patch password_url(user_id: @user.id), params: { 
      password: "nova_senha_valida", 
      password_confirmation: "senha_diferente" 
    }
    
    assert_response :unprocessable_entity
    assert_equal "A senha deve conter no mínimo 8 caracteres e coincidir com a confirmação", flash.now[:alert]
  end
  
end  