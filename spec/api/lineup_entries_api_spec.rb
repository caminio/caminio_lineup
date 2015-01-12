require 'spec_helper'

describe Caminio::V1::LineupEntries do

  describe "/lineup_entries" do

    before :each do
      @user = create(:user)
      @url = "v1/lineup_entries"
      header 'Authorization', "Bearer #{@user.aquire_api_key.token}"
      header 'Organization-id', @user.organizations.first
    end

    it "returns lineup_entries json" do
      get @url
      expect( last_response.status ).to be == 200
      expect( json ).to have_key(:lineup_entries)
    end

    # describe "json return properties" do

    #   before :each do
    #     get "v1/users/#{@user.id}"
    #   end

    #   it{ expect( json.user ).to have_key(:id) }
    #   it{ expect( json.user ).to have_key(:username) }
    #   it{ expect( json.user ).to have_key(:firstname) }
    #   it{ expect( json.user ).to have_key(:lastname) }
    #   it{ expect( json.user ).to have_key(:email) }
    #   it{ expect( json.user ).to have_key(:admin) }
    #   it{ expect( json.user ).to have_key(:editor) }
    #   it{ expect( json.user ).not_to have_key(:password_digest) }

    # end

  end
end

