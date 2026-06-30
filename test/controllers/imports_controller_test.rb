require "test_helper"

class ImportsControllerTest < ActionDispatch::IntegrationTest
  self.use_transactional_tests = false

  setup do
    ActiveRecord::Base.connection.disable_referential_integrity do
      User.delete_all
    end

    
    @user = User.create!(
      name: "Rebeca", 
      email: "rebeca@teste.com", 
      status: "pre-cadastrado", 
      role: "administrador", 
      password: "secret"   
    )
    
    post sessions_url, params: { email: @user.email, password: 'secret' }
  end

  test "should get new" do
    get new_import_url
    assert_response :success
  end

  test "should create import" do
    file = fixture_file_upload('participants.csv', 'text/csv')

    post imports_url, params: { file: file }
    
    assert_response :redirect
    assert_redirected_to new_import_path
    assert_equal "Participantes importados com sucesso", flash[:notice]
  end
end