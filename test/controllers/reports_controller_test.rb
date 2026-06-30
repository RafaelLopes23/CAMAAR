require "test_helper"

class ReportsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    post sessions_url, params: { email: @user.email, password: 'secret' }
  end

  # Teste o caso do "Turma de Algoritmos" (cobre o if)
  test "should get index with alert for specific turma" do
    get reports_index_url, params: { turma: "Turma de Algoritmos" }
    
    assert_response :success
    assert_equal "Dados insuficientes para gerar o relatório desta turma", flash[:alert]
  end

  # Teste o caso de uma turma válida (cobre o elsif)
  test "should get index with notice for other turma" do
    get reports_index_url, params: { turma: "Outra Turma" }
    
    assert_response :success
    assert_equal "Relatório consolidado", flash[:notice]
  end

  # Teste o caso padrão, sem parâmetros (cobre o que já tínhamos)
  test "should get index without params" do
    get reports_index_url
    assert_response :success
  end
end