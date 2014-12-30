require File.expand_path(File.dirname(__FILE__) + '/../../minitest_helper')

describe Age do

  before do
    Timecop.freeze(Date.parse('2/12/2014'))
  end

  it "should match a m/d/y format" do
    Age.for( { 'data' => { 'birth_date' => '05/25/1979' } } ).must_equal 35
    Age.for( { 'data' => { 'birth_date' => '12/25/1979' } } ).must_equal 34
  end

  it "should allow a birth_date that is not in a data block" do
    Age.for( { 'birth_date' => '05/25/1979' } ).must_equal 35
    Age.for( { 'birth_date' => '12/25/1979' } ).must_equal 34
  end

  it "should not require a zero in the front" do
    Age.for( { 'data' => { 'birth_date' => '5/25/1981' } } ).must_equal 33
  end

  it "should not require a zero in the day" do
    Age.for( { 'data' => { 'birth_date' => '5/05/1982' } } ).must_equal 32
  end

  it "should work with dashes" do
    Age.for( { 'data' => { 'birth_date' => '5-5-1982' } } ).must_equal 32
    Age.for( { 'data' => { 'birth_date' => '05-05-1982' } } ).must_equal 32
    Age.for( { 'birth_date' => '05-05-1982' } ).must_equal 32
  end

  it "should return zero if the date is bad" do
    Age.for( { 'data' => { 'birth_date' => '2-999-1982' } } ).must_equal 0
    Age.for( { 'data' => { 'birth_date' => 'uuugh' } } ).must_equal 0
    Age.for( { 'data' => { 'birth_date' => nil } } ).must_equal 0
  end

end
