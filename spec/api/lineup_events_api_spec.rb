require 'spec_helper'

describe Caminio::V1::LineupEvents do

  describe "POST /lineup_events", focus: true do

    before :each do
      @user = create(:user)
      @lineup_entry = create(:lineup_entry)  
      @lineup_venue = create(:lineup_venue)
      @lineup_ensemble = create(:lineup_ensemble)
      header 'Authorization', "Bearer #{@user.aquire_api_key.token}"
    end

    let(:url){ 'v1/lineup_events' }
    let(:error_400){ 'lineup_event is missing' }
    let(:post_attr){ { 
      lineup_event: { 
        starts: DateTime.new(), 
        lineup_venue_id: @lineup_venue.id, 
        lineup_ensemble_ids: [ @lineup_ensemble.id ] }, 
      lineup_entry_id: @lineup_entry.id } 
    }

    describe "requires" do

      it { post(url); expect( last_response.status ).to be == 400 }

      it { post(url); expect( json.error ).to be == error_400 }

      it { post(url, { lineup_event: { } } ); expect( json.error ).to be == error_400 }

    end

    describe "returns lineup_event" do
      
      before :each do
        post url, post_attr 
      end

      it{ expect( last_response.status ).to be == 201 }
      it{ expect( json ).to have_key :lineup_event }
      it{ expect( json.lineup_event ).to have_key :lineup_venue_id }
      it{ expect( json.lineup_event ).to have_key :lineup_ensemble_ids }
      it{ expect( json ).to have_key :lineup_entry }
      it{ expect( json ).to have_key :lineup_venue }
      it{ expect( json ).to have_key :lineup_ensembles }

    end

  end

  describe "PUT /lineup_events/:id" do

    before :each do
      @user = create(:user)
      @lineup_entry = create(:lineup_entry)
      @lineup_event = @lineup_entry.events.create(starts: DateTime.new())      
      header 'Authorization', "Bearer #{@user.aquire_api_key.token}"
      header 'Organization-id', @user.organizations.first
    end

    describe "update" do

      describe "title" do

        before :each do
          @new_starts = DateTime.new() 
          put "v1/lineup_events/#{@lineup_event.id}", { lineup_event: { starts: @new_starts }, lineup_entry_id: @lineup_entry.id  }
        end

        it { expect( last_response.status ).to eq(200) }
        it { expect( DateTime.parse( json.lineup_event.starts ) ).to eq( @new_starts ) }
        it { expect( json ).to have_key :lineup_entry }
        it { expect( json ).to have_key :lineup_venue }
        it { expect( json ).to have_key :lineup_ensembles }

      end

    end

  end

  describe "DELETE /lineup_events/:id" do

    before :each do
      @user = create(:user)
      @lineup_entry = create(:lineup_entry)
      @lineup_event = @lineup_entry.events.create(starts: Date.new())      
      header 'Authorization', "Bearer #{@user.aquire_api_key.token}"
      header 'Organization-id', @user.organizations.first
      delete "v1/lineup_events/#{@lineup_event.id}", { lineup_entry_id: @lineup_entry.id  }
    end

    it{ expect( last_response.status ).to be == 200 }
    it{ expect( json ).to eq({}) }

  end

end

