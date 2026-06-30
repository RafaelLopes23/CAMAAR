require "test_helper"

class FormsControllerTest < ActionDispatch::IntegrationTest
  setup do
    # Sua variável original mantida
    @form = forms(:one)
    
    # Adicionamos o usuário e o login para liberar todos os testes abaixo!
    @user = users(:one)
    post sessions_url, params: { email: @user.email, password: 'secret' }
  end

  test "should get index" do
    get forms_url
    assert_response :success
  end

  test "should get new" do
    get new_form_url
    assert_response :success
  end

  test "should create form" do
    assert_difference("Form.count") do
      post forms_url, params: { form: { template_id: @form.template_id, title: @form.title } }
    end

    assert_redirected_to form_url(Form.last)
  end

  test "should show form" do
    get form_url(@form)
    assert_response :success
  end

  test "should get edit" do
    get edit_form_url(@form)
    assert_response :success
  end

  test "should update form" do
    patch form_url(@form), params: { form: { template_id: @form.template_id, title: @form.title } }
    assert_redirected_to form_url(@form)
  end

  test "should destroy form" do
    assert_difference("Form.count", -1) do
      delete form_url(@form)
    end

    assert_redirected_to forms_url
  end

# 1. Teste de erro na criação (cobre o 'else' do create)
  test "should not create form with invalid params" do
    assert_no_difference("Form.count") do
      # Tenta criar sem o 'title', que provavelmente é obrigatório no seu model
      post forms_url, params: { form: { title: "", template_id: @form.template_id } }
    end

    assert_response :unprocessable_content
  end

  # 2. Teste de erro na atualização (cobre o 'else' do update)
  test "should not update form with invalid params" do
    patch form_url(@form), params: { form: { title: "" } }
    
    assert_response :unprocessable_content
  end
end