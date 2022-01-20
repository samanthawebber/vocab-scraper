require 'rails_helper'

describe "GET /sentences/:id" do
  
  it "returns http success" do
    get "/sentences/1"
    expect(response).to have_http_status(:success)
  end
end


