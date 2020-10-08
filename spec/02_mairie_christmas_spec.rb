require_relative '../lib/02_mairie_christmas.rb'


describe "the one_address method" do
  it "should return the address of the avernes mairie" do
    expect(one_address).to eq("mairie.avernes@orange.fr")
  end
end
