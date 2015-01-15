require 'spec_helper'

describe Caminio::V1::LineupEntries do

  describe "/lineup_entries" do

    before :each do
      @user = create(:user)
      @lineup_entry = create(:lineup_entry)
      @lineup_event = @lineup_entry.events.create(starts: Date.new())   
      @url = "v1/lineup_entries"
      header 'Authorization', "Bearer #{@user.aquire_api_key.token}"
      header 'Organization-id', @user.organizations.first
    end

    it "returns lineup_entries json" do
      get @url
      expect( last_response.status ).to be == 200
      expect( json ).to have_key(:lineup_entries)
      expect( json ).to have_key(:lineup_events)
    end

    describe "json return properties" do

      before :each do
        get "v1/lineup_entries/#{@lineup_entry.id}"
      end

      it{ expect( json.lineup_entry ).to have_key(:id) }
      it{ expect( json.lineup_entry ).to have_key(:categories) }
      it{ expect( json.lineup_entry ).to have_key(:age) }
      it{ expect( json.lineup_entry ).to have_key(:recommended_age) }
      it{ expect( json.lineup_entry ).to have_key(:duration_min) }
      it{ expect( json.lineup_entry ).to have_key(:num_breaks) }
      it{ expect( json.lineup_entry ).to have_key(:lineup_event_ids) }
      it{ expect( json ).to have_key(:lineup_events) }

    end

  end
  describe "POST /lineup_entries", focus: true do

    before :each do
      @user = create(:user)
      header 'Authorization', "Bearer #{@user.aquire_api_key.token}"
    end

    let(:url){ 'v1/lineup_entries' }
    let(:error_400){ 'lineup_entry is missing' }
    let(:post_attr){ { lineup_entry: { categories: ["two", "three"] } } }

    describe "requires" do

      it { post(url); expect( last_response.status ).to be == 400 }

      it { post(url); expect( json.error ).to be == error_400 }

      it { post(url, { lineup_entry: { } } ); expect( json.error ).to be == error_400 }

    end

    describe "returns lineup_entry" do
      
      before :each do
        post url, post_attr 
      end

      it{ expect( last_response.status ).to be == 201 }

      it{ expect( json ).to have_key :lineup_entry }
      it{ expect( json.lineup_entry ).to have_key(:lineup_event_ids) }
      it{ expect( json ).to have_key(:lineup_events) }

    end

  end

  describe "PUT /lineup_entries/:id" do

    before :each do
      @user = create(:user)
      @lineup_entry = create(:lineup_entry)
      header 'Authorization', "Bearer #{@user.aquire_api_key.token}"
      header 'Organization-id', @user.organizations.first
    end

    describe "update" do

      describe "categories" do

        before :each do
          @new_categories = ["new", "categories"]
          put "v1/lineup_entries/#{@lineup_entry.id}", { lineup_entry: { categories: @new_categories } }
        end

        it { expect( last_response.status ).to eq(200) }
        it { expect( json.lineup_entry.categories ).to eq( @new_categories ) }
        it{ expect( json.lineup_entry ).to have_key(:lineup_event_ids) }
        it{ expect( json ).to have_key(:lineup_events) }

      end

    end

  end

  describe "DELETE /lineup_entries/:id" do

    before :each do
      @user = create(:user)
      @lineup_entry = create(:lineup_entry)
      header 'Authorization', "Bearer #{@user.aquire_api_key.token}"
      header 'Organization-id', @user.organizations.first
      delete "v1/lineup_entries/#{@lineup_entry.id}"
    end

    it{ expect( last_response.status ).to be == 200 }
    it{ expect( json ).to eq({}) }

  end

end

