require "test_helper"

class TemplatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @template = templates(:one)
    
    
    @user = users(:one) 
    
   
    post sessions_url, params: { email: @user.email, password: 'secret' }
  end

  test "should get index" do
    get templates_url
    assert_response :success
  end

  test "should get new" do
    get new_template_url
    assert_response :success
  end

  test "should create template" do
    assert_difference("Template.count") do
      post templates_url, params: { template: { description: @template.description, name: @template.name } }
    end

    assert_redirected_to template_url(Template.last)
  end

  test "should show template" do
    get template_url(@template)
    assert_response :success
  end

  test "should get edit" do
    get edit_template_url(@template)
    assert_response :success
  end

  test "should update template" do
    patch template_url(@template), params: { template: { description: @template.description, name: @template.name } }
    assert_redirected_to template_url(@template)
  end

 test "should destroy template" do

    Response.delete_all
    Form.delete_all

    assert_difference("Template.count", -1) do
      delete template_url(@template)
    end

    assert_redirected_to templates_url
  end

  test "should not create template with invalid params" do
    assert_no_difference("Template.count") do
      post templates_url, params: { template: { name: "", description: "" } }
    end
    assert_response :unprocessable_content
  end

  test "should not update template with invalid params" do
    patch template_url(@template), params: { template: { name: "" } }
    assert_response :unprocessable_content
  end

  test "should not destroy template if it has forms" do
    
    assert_no_difference("Template.count") do
      delete template_url(@template)
    end
    
    assert_redirected_to templates_path
    assert_equal "Não é possível excluir um template que já possui formulários vinculados", flash[:alert]
  end
end