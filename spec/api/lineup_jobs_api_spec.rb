require 'spec_helper'

describe Caminio::V1::LineupJobs do

  include APIHelper

  classname = "lineup_job"

  before :each do
    create_user_and_set_header
    # set_class classname
  end

  # describe "/lineup_jobs" do

  #   before :each do
  #     @user = create(:user)
  #     @lineup_job = create(:lineup_job)
  #     @url = "v1/lineup_jobs"
  #     header 'Authorization', "Bearer #{@user.aquire_api_key.token}"
  #     header 'Organization-id', @user.organizations.first
  #   end

  #   it "returns lineup_jobs json" do
  #     get @url
  #     expect( last_response.status ).to be == 200
  #     expect( json ).to have_key(:lineup_jobs)
  #   end

  #   describe "json return properties" do

  #     before :each do
  #       get "v1/lineup_jobs/#{@lineup_job.id}"
  #     end

  #     it{ expect( json.lineup_job ).to have_key(:id) }
      
  #     it{ expect( json.lineup_job ).to have_key(:title) }
  #     it{ expect( json.lineup_job ).to have_key(:description) }

  #   end

  # end

  describe "POST /lineup_jobs" do

    before :each do
      @lineup_entry = create(:lineup_entry)  
    end

    let(:url){ 'v1/lineup_jobs' }
    let(:error_400){ 'lineup_job is missing' }
    let(:post_attr){ { lineup_job: { title: "another job" }, lineup_entry_id: @lineup_entry.id } }

    describe "requires" do

      it { post(url); expect( last_response.status ).to be == 400 }

      it { post(url); expect( json.error ).to be == error_400 }

      it { post(url, { lineup_job: { } } ); expect( json.error ).to be == error_400 }

    end

    describe "returns lineup_job" do
      
      before :each do
        post url, post_attr 
      end

      it{ expect( last_response.status ).to be == 201 }

      it{ expect( json ).to have_key :lineup_job }
      it{ expect( json[:lineup_job] ).to have_key :lineup_person_id }
      it{ expect( json ).to have_key :lineup_person }
      it{ expect( json ).to have_key :lineup_entry }

    end

  end

  describe "PUT /lineup_jobs/:id" do

    before :each do
      @lineup_entry = create(:lineup_entry)
      @lineup_job = @lineup_entry.jobs.create(title: "a job")     
    end

    describe "update" do

      describe "title" do

        before :each do
          @new_title = "a new job"
          put "v1/lineup_jobs/#{@lineup_job.id}", { lineup_job: { title: @new_title }, lineup_entry_id: @lineup_entry.id }
        end
        
        it { expect( last_response.status ).to eq(200) }
        it { expect( json.lineup_job.title ).to eq( @new_title ) }
        it { expect( json[:lineup_job] ).to have_key :lineup_person_id }
        it { expect( json ).to have_key :lineup_person }
        it { expect( json ).to have_key :lineup_entry }

      end

    end

  end

  describe "DELETE /lineup_jobs/:id" do

    before :each do
      @lineup_entry = create(:lineup_entry)
      @lineup_job = @lineup_entry.jobs.create(title: "a job")   
      delete "v1/lineup_jobs/#{@lineup_job.id}", { lineup_entry_id: @lineup_entry.id }
    end

    it{ expect( last_response.status ).to be == 200 }
    it{ expect( json ).to eq({}) }

  end

end

