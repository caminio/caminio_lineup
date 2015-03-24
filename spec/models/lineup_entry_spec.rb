require 'spec_helper'

describe LineupEntry do

  let!(:user){ create(:user) }
  let!(:entry){ create(:lineup_entry) }

  it "has press quotes" do
    expect( entry.quotes.length ).to eq 0 
    entry.quotes.create( title: "new quote" )
    expect( entry.quotes.length ).to eq 1 
    expect( entry.save ).to be true
  end

end
