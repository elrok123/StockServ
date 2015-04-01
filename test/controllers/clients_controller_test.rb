require 'test_helper'

class ClientsControllerTest < ActionController::TestCase
  test "should get get_clients" do
    get :get_clients
    assert_response :success
  end

end
