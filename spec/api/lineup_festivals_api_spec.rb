require 'spec_helper'

describe Caminio::V1::LineupFestivals do

  describe "/lineup_festivals" do

    before :each do
      @user = create(:user)
      @lineup_festival = create(:lineup_festival)
      @url = "v1/lineup_festivals"
      header 'Authorization', "Bearer #{@user.aquire_api_key.token}"
      header 'Organization-id', @user.organizations.first
    end

    it "returns lineup_festivals json" do
      get @url
      expect( last_response.status ).to be == 200
      expect( json ).to have_key(:lineup_festivals)
    end

    describe "json return properties" do

      before :each do
        get "v1/lineup_festivals/#{@lineup_festival.id}"
      end

      it{ expect( json.lineup_festival ).to have_key(:id) }
      it{ expect( json.lineup_festival ).to have_key(:title) }
      it{ expect( json.lineup_festival ).to have_key(:description) }
      it{ expect( json.lineup_festival ).to have_key(:lineup_entry_ids) }
      it{ expect( json ).to have_key(:lineup_entries) }
      it{ expect( json ).to have_key(:lineup_jobs) }
      it{ expect( json ).to have_key(:lineup_events) }

    end

  end
  describe "POST /lineup_festivals", focus: true do

    before :each do
      @user = create(:user)
      header 'Authorization', "Bearer #{@user.aquire_api_key.token}"
    end

    let(:url){ 'v1/lineup_festivals' }
    let(:error_400){ 'lineup_festival is missing' }
    let(:post_attr){ { lineup_festival: { title: "a new festival" } } }

    describe "requires" do

      it { post(url); expect( last_response.status ).to be == 400 }

      it { post(url); expect( json.error ).to be == error_400 }

      it { post(url, { lineup_festival: { } } ); expect( json.error ).to be == error_400 }

    end

    describe "returns lineup_festival" do
      
      before :each do
        post url, post_attr 
      end

      it{ expect( last_response.status ).to be == 201 }

      it{ expect( json ).to have_key :lineup_festival }

    end

  end

  describe "PUT /lineup_festivals/:id" do

    before :each do
      @user = create(:user)
      @lineup_festival = create(:lineup_festival)
      header 'Authorization', "Bearer #{@user.aquire_api_key.token}"
      header 'Organization-id', @user.organizations.first
    end

    describe "update" do

      describe "title" do

        before :each do
          @new_title = "another festival"
          put "v1/lineup_festivals/#{@lineup_festival.id}", { lineup_festival: { title: @new_title } }
        end

        it { expect( last_response.status ).to eq(200) }
        it { expect( json.lineup_festival.title ).to eq( @new_title ) }

      end

    end

  end

  describe "DELETE /lineup_festivals/:id" do

    before :each do
      @user = create(:user)
      @lineup_festival = create(:lineup_festival)
      header 'Authorization', "Bearer #{@user.aquire_api_key.token}"
      header 'Organization-id', @user.organizations.first
      delete "v1/lineup_festivals/#{@lineup_festival.id}"
    end

    it{ expect( last_response.status ).to be == 200 }
    it{ expect( json ).to eq({}) }

  end

end

