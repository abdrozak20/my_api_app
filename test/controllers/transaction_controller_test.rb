require "test_helper"

class TransactionControllerTest < ActionDispatch::IntegrationTest
  test "should get store" do
    get transaction_store_url
    assert_response :success
  end
end
