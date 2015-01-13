require 'spec_helper'

describe Caminio::V1::LineupPersons do

  describe "/lineup_persons" do

    before :each do
      @user = create(:user)
      @lineup_person = create(:lineup_person)
      @url = "v1/lineup_persons"
      header 'Authorization', "Bearer #{@user.aquire_api_key.token}"
      header 'Organization-id', @user.organizations.first
    end

    it "returns lineup_persons json" do
      get @url
      expect( last_response.status ).to be == 200
      expect( json ).to have_key(:lineup_persons)
    end

    describe "json return properties" do

      before :each do
        get "v1/lineup_persons/#{@lineup_person.id}"
      end

      it{ expect( json.lineup_person ).to have_key(:id) }
      
      it{ expect( json.lineup_person ).to have_key(:firstname) }
      it{ expect( json.lineup_person ).to have_key(:midname) }
      it{ expect( json.lineup_person ).to have_key(:lastname) }
      
      it{ expect( json.lineup_person ).to have_key(:email) }
      it{ expect( json.lineup_person ).to have_key(:phone) }
      it{ expect( json.lineup_person ).to have_key(:position) }

      it{ expect( json.lineup_person ).to have_key(:tags) }
      it{ expect( json.lineup_person ).to have_key(:ext_ref_id) }
      it{ expect( json.lineup_person ).to have_key(:ext_ref_src) }
      it{ expect( json.lineup_person ).to have_key(:ext_ref_note) }
      it{ expect( json.lineup_person ).to have_key(:ext_ref_sync_at) }
      it{ expect( json.lineup_person ).to have_key(:orig_url) }
      it{ expect( json.lineup_person ).to have_key(:ext_url) }
      it{ expect( json.lineup_person ).to have_key(:video_url) }
      it{ expect( json.lineup_person ).to have_key(:video_type) }
      it{ expect( json.lineup_person ).to have_key(:others_write) }
      it{ expect( json.lineup_person ).to have_key(:notify_me_on_write) }

    end

  end
  describe "POST /lineup_persons" do

    before :each do
      @user = create(:user)
      header 'Authorization', "Bearer #{@user.aquire_api_key.token}"
    end

    let(:url){ 'v1/lineup_persons' }
    let(:error_400){ 'lineup_person is missing' }
    let(:post_attr){ { lineup_person: { firstname: "8:00-18:00" } } }

    describe "requires" do

      it { post(url); expect( last_response.status ).to be == 400 }

      it { post(url); expect( json.error ).to be == error_400 }

      it { post(url, { lineup_person: { } } ); expect( json.error ).to be == error_400 }

    end

    describe "returns lineup_person" do
      
      before :each do
        post url, post_attr 
      end

      it{ expect( last_response.status ).to be == 201 }

      it{ expect( json ).to have_key :lineup_person }

    end

  end

  describe "PUT /lineup_persons/:id" do

    before :each do
      @user = create(:user)
      @lineup_person = create(:lineup_person)
      header 'Authorization', "Bearer #{@user.aquire_api_key.token}"
      header 'Organization-id', @user.organizations.first
    end

    describe "update" do

      describe "firstname" do

        before :each do
          @new_firstname = "alexander"
          put "v1/lineup_persons/#{@lineup_person.id}", { lineup_person: { firstname: @new_firstname } }
        end

        it { expect( last_response.status ).to eq(200) }
        it { expect( json.lineup_person.firstname ).to eq( @new_firstname ) }

      end

    end

  end

  describe "DELETE /lineup_persons/:id" do

    before :each do
      @user = create(:user)
      @lineup_person = create(:lineup_person)
      header 'Authorization', "Bearer #{@user.aquire_api_key.token}"
      header 'Organization-id', @user.organizations.first
      delete "v1/lineup_persons/#{@lineup_person.id}"
    end

    it{ expect( last_response.status ).to be == 200 }
    it{ expect( json ).to eq({}) }

  end

end

