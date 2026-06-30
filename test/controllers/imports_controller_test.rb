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

    assert_difference("User.count", 2) do
      post imports_url, params: { file: file }
    end

    assert_response :redirect
    assert_redirected_to new_import_path
    assert_equal "Participantes importados com sucesso", flash[:notice]
  end

  test "should reject unsupported import format" do
    file = fixture_file_upload("participants.txt", "text/plain")

    assert_no_difference("User.count") do
      post imports_url, params: { file: file }
    end

    assert_response :redirect
    assert_redirected_to new_import_path
    assert_equal "Formato de arquivo não suportado", flash[:alert]
  end
end
