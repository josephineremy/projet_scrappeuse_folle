require_relative '../lib/crypto_scrapper.rb'
describe "return an array of hashes of crypto and price" do
  it "should not return nil" do
    expect(create_arr(MY_URL)).not_to be_nil
  end
  it "should return an array longer than 100" do
    arr = create_arr(MY_URL)
    expect(arr.size).to be > 100
  end
end
