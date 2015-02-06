require 'spec_helper'

describe Caminio::V1::LineupVenues do

  describe "/lineup_venues" do

    before :each do
      @user = create(:user)
      @lineup_venue = create(:lineup_venue)
      @url = "v1/lineup_venues"
      header 'Authorization', "Bearer #{@user.aquire_api_key.token}"
      header 'Organization-id', @user.organizations.first
    end

    it "returns lineup_venues json" do
      get @url
      expect( last_response.status ).to be == 200
      expect( json ).to have_key(:lineup_venues)
    end

    describe "json return properties" do

      before :each do
        get "v1/lineup_venues/#{@lineup_venue.id}"
      end

      it{ expect( json.lineup_venue ).to have_key(:id) }
      it{ expect( json.lineup_venue ).to have_key(:opening_hours) }
      it{ expect( json.lineup_venue ).to have_key(:reach_by_bus) }
      it{ expect( json.lineup_venue ).to have_key(:reach_by_tram) }
      it{ expect( json.lineup_venue ).to have_key(:reach_by_train) }
      it{ expect( json.lineup_venue ).to have_key(:tags) }
      it{ expect( json.lineup_venue ).to have_key(:ext_ref_id) }
      it{ expect( json.lineup_venue ).to have_key(:ext_ref_src) }
      it{ expect( json.lineup_venue ).to have_key(:ext_ref_note) }
      it{ expect( json.lineup_venue ).to have_key(:ext_ref_sync_at) }
      it{ expect( json.lineup_venue ).to have_key(:orig_url) }
      it{ expect( json.lineup_venue ).to have_key(:ext_url) }
      it{ expect( json.lineup_venue ).to have_key(:video_url) }
      it{ expect( json.lineup_venue ).to have_key(:video_type) }
      it{ expect( json.lineup_venue ).to have_key(:others_write) }
      it{ expect( json.lineup_venue ).to have_key(:notify_me_on_write) }

    end

  end
  describe "POST /lineup_venues" do

    before :each do
      @user = create(:user)
      header 'Authorization', "Bearer #{@user.aquire_api_key.token}"
    end

    let(:url){ 'v1/lineup_venues' }
    let(:error_400){ 'lineup_venue is missing, lineup_venue[title] is missing' }
    let(:post_attr){ { lineup_venue: { opening_hours: "8:00-18:00",  title: "test venue" } } }

    describe "requires" do

      it { post(url); expect( last_response.status ).to be == 400 }

      it { post(url); expect( json.error ).to be == error_400 }

      it { post(url, { lineup_venue: {} } ); expect( json.error ).to be == error_400 }

    end

    describe "returns lineup_venue" do
      
      before :each do
        post url, post_attr 
      end

      it{ expect( last_response.status ).to be == 201 }

      it{ expect( json ).to have_key :lineup_venue }

    end

  end

  describe "PUT /lineup_venues/:id" do

    before :each do
      @user = create(:user)
      @lineup_venue = create(:lineup_venue)
      header 'Authorization', "Bearer #{@user.aquire_api_key.token}"
      header 'Organization-id', @user.organizations.first
    end

    describe "update" do

      describe "opening_hours" do

        before :each do
          @new_opening_hours = "9:00-19:00"
          put "v1/lineup_venues/#{@lineup_venue.id}", { lineup_venue: { opening_hours: @new_opening_hours } }
        end

        it { expect( last_response.status ).to eq(200) }
        it { expect( json.lineup_venue.opening_hours ).to eq( @new_opening_hours ) }

      end

    end

  end

  describe "DELETE /lineup_venues/:id" do

    before :each do
      @user = create(:user)
      @lineup_venue = create(:lineup_venue)
      header 'Authorization', "Bearer #{@user.aquire_api_key.token}"
      header 'Organization-id', @user.organizations.first
      delete "v1/lineup_venues/#{@lineup_venue.id}"
    end

    it{ expect( last_response.status ).to be == 200 }
    it{ expect( json ).to eq({}) }

  end

end

