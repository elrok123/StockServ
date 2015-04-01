require 'test_helper'

class PortfoliosControllerTest < ActionController::TestCase
  test "should get sell" do
    get :sell
    assert_response :success
  end

end
