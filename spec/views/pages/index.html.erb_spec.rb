require 'rails_helper'

RSpec.describe "pages/index.html.erb", type: :view do
  it "displays the home page" do
    render

    expect(response.body).to match(/Collect all of your stuff/)
  end
end
