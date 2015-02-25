require 'spec_helper'

describe LineupVenue do

  describe "LineupVenue" do

    let!(:user){ create(:user) }
    let(:venue){ create(:lineup_venue) }
    let(:entry){ create(:lineup_entry) }
    let!(:event){ entry.events.create( starts: DateTime.now, lineup_venue: venue )}
  
    it "destroys dependent events" do
      expect( entry.events.length ).to eq(1)
      venue.destroy
      expect( LineupEntry.find( entry.id ).events.length ).to eq(0)
    end

  end

end
