require_relative '../../../../test_helper'

class Comfy::Admin::Cms::CategoriesControllerTest < ActionController::TestCase
  
  def test_get_edit
    xhr :get, :edit, :site_id => comfy_cms_sites(:default), :id => comfy_cms_categories(:default)
    assert_response :success
    assert_template :edit
    assert assigns(:category)
  end
  
  def test_get_edit_failure
    xhr :get, :edit, :site_id => comfy_cms_sites(:default), :id => 'invalid'
    assert_response :success
    assert response.body.blank?
  end
  
  def test_creation
    assert_difference 'Comfy::Cms::Category.count' do
      xhr :post, :create, :site_id => comfy_cms_sites(:default), :category => {
        :label            => 'Test Label',
        :categorized_type => 'Comfy::Cms::Snippet'
      }
      assert_response :success
      assert_template :create
      assert assigns(:category)
    end
  end
  
  def test_creation_failure
    assert_no_difference 'Comfy::Cms::Category.count' do
      xhr :post, :create, :site_id => comfy_cms_sites(:default), :category => { }
      assert_response :success
      assert response.body.blank?
    end
  end
  
  def test_update
    category = comfy_cms_categories(:default)
    xhr :put, :update, :site_id => comfy_cms_sites(:default), :id => category, :category => {
      :label => 'Updated Label'
    }
    assert_response :success
    assert_template :update
    assert assigns(:category)
    category.reload
    assert_equal 'Updated Label', category.label
  end
  
  def test_update_failure
    category = comfy_cms_categories(:default)
    xhr :put, :update, :site_id => comfy_cms_sites(:default), :id => category, :category => {
      :label => ''
    }
    assert_response :success
    assert response.body.blank?
    category.reload
    assert_not_equal '', category.label
  end
  
  def test_destroy
    assert_difference 'Comfy::Cms::Category.count', -1 do
      xhr :delete, :destroy, :site_id => comfy_cms_sites(:default), :id => comfy_cms_categories(:default)
      assert assigns(:category)
      assert_response :success
      assert_template :destroy
    end
  end
  
end