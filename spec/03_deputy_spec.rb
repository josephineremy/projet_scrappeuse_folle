require_relative '../lib/03_deputy.rb'


describe "the one_address method" do
  it "should return the address of the email address of Jean Lassalle " do
    expect(one_address).to eq("jean.lassalle@assemblee-nationale.fr")
  end
end
