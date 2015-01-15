require 'spec_helper'

describe Caminio::V1::LineupEnsembles do

  describe "/lineup_ensembles" do

    before :each do
      @user = create(:user)
      @lineup_ensemble = create(:lineup_ensemble)
      @url = "v1/lineup_ensembles"
      header 'Authorization', "Bearer #{@user.aquire_api_key.token}"
      header 'Organization-id', @user.organizations.first
    end

    it "returns lineup_ensembles json" do
      get @url
      expect( last_response.status ).to be == 200
      expect( json ).to have_key(:lineup_ensembles)
    end

    describe "json return properties" do

      before :each do
        get "v1/lineup_ensembles/#{@lineup_ensemble.id}"
      end

      it{ expect( json.lineup_ensemble ).to have_key(:id) }
      it{ expect( json.lineup_ensemble ).to have_key(:title) }
      it{ expect( json.lineup_ensemble ).to have_key(:description) }
      it{ expect( json.lineup_ensemble ).to have_key(:lineup_entry_ids) }
      it{ expect( json.lineup_ensemble ).to have_key(:lineup_person_ids) }
      it{ expect( json ).to have_key(:lineup_entries) }
      it{ expect( json ).to have_key(:lineup_persons) }

    end

  end
  describe "POST /lineup_ensembles", focus: true do

    before :each do
      @user = create(:user)
      header 'Authorization', "Bearer #{@user.aquire_api_key.token}"
    end

    let(:url){ 'v1/lineup_ensembles' }
    let(:error_400){ 'lineup_ensemble is missing' }
    let(:post_attr){ { lineup_ensemble: { title: "a new ensemble" } } }

    describe "requires" do

      it { post(url); expect( last_response.status ).to be == 400 }

      it { post(url); expect( json.error ).to be == error_400 }

      it { post(url, { lineup_ensemble: { } } ); expect( json.error ).to be == error_400 }

    end

    describe "returns lineup_ensemble" do
      
      before :each do
        post url, post_attr 
      end

      it{ expect( last_response.status ).to be == 201 }

      it{ expect( json ).to have_key :lineup_ensemble }

    end

  end

  describe "PUT /lineup_ensembles/:id" do

    before :each do
      @user = create(:user)
      @lineup_ensemble = create(:lineup_ensemble)
      header 'Authorization', "Bearer #{@user.aquire_api_key.token}"
      header 'Organization-id', @user.organizations.first
    end

    describe "update" do

      describe "title" do

        before :each do
          @new_title = "another ensemble"
          put "v1/lineup_ensembles/#{@lineup_ensemble.id}", { lineup_ensemble: { title: @new_title } }
        end

        it { expect( last_response.status ).to eq(200) }
        it { expect( json.lineup_ensemble.title ).to eq( @new_title ) }

      end

    end

  end

  describe "DELETE /lineup_ensembles/:id" do

    before :each do
      @user = create(:user)
      @lineup_ensemble = create(:lineup_ensemble)
      header 'Authorization', "Bearer #{@user.aquire_api_key.token}"
      header 'Organization-id', @user.organizations.first
      delete "v1/lineup_ensembles/#{@lineup_ensemble.id}"
    end

    it{ expect( last_response.status ).to be == 200 }
    it{ expect( json ).to eq({}) }

  end

end

