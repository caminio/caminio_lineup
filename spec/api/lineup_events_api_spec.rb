require 'spec_helper'

describe Caminio::V1::LineupEvents do

  describe "/lineup_events" do

    before :each do
      @user = create(:user)
      @lineup_event = create(:lineup_event)
      @url = "v1/lineup_events"
      header 'Authorization', "Bearer #{@user.aquire_api_key.token}"
      header 'Organization-id', @user.organizations.first
    end

    it "returns lineup_events json" do
      get @url
      expect( last_response.status ).to be == 200
      expect( json ).to have_key(:lineup_events)
    end

    describe "json return properties" do

      before :each do
        get "v1/lineup_events/#{@lineup_event.id}"
      end

      it{ expect( json.lineup_event ).to have_key(:id) }
      it{ expect( json.lineup_event ).to have_key(:starts) }

    end

  end
  describe "POST /lineup_events", focus: true do

    before :each do
      @user = create(:user)
      header 'Authorization', "Bearer #{@user.aquire_api_key.token}"
    end

    let(:url){ 'v1/lineup_events' }
    let(:error_400){ 'lineup_event is missing' }
    let(:post_attr){ { lineup_event: { starts: Date.new() } } }

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

    end

  end

  describe "PUT /lineup_events/:id" do

    before :each do
      @user = create(:user)
      @lineup_event = create(:lineup_event)
      header 'Authorization', "Bearer #{@user.aquire_api_key.token}"
      header 'Organization-id', @user.organizations.first
    end

    describe "update" do

      describe "title" do

        before :each do
          @new_starts = Date.new() 
          put "v1/lineup_events/#{@lineup_event.id}", { lineup_event: { starts: @new_starts } }
        end

        it { expect( last_response.status ).to eq(200) }
        it { expect( DateTime.parse( json.lineup_event.starts ) ).to eq( @new_starts ) }

      end

    end

  end

  describe "DELETE /lineup_events/:id" do

    before :each do
      @user = create(:user)
      @lineup_event = create(:lineup_event)
      header 'Authorization', "Bearer #{@user.aquire_api_key.token}"
      header 'Organization-id', @user.organizations.first
      delete "v1/lineup_events/#{@lineup_event.id}"
    end

    it{ expect( last_response.status ).to be == 200 }
    it{ expect( json ).to eq({}) }

  end

end

