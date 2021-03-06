require_relative 'spec_helper'

describe "Rider class" do

  describe "Initialize method" do
    it "Each instance has an ID, name, and phone number" do
      rider_id = "0000"
      name = "Buddy"
      phone_num = "555-5555"
      rider = RideShare::Rider.new(rider_id, name, phone_num)

      rider.must_respond_to :rider_id
      rider.rider_id.must_equal rider_id

      rider.must_respond_to :name
      rider.name.must_equal name
    end
  end

  describe "Trips method" do
    it "Retrieves list of trip instances that given rider instance has taken" do
      rider_trips = RideShare::Rider.find("296").trips
      rider_trips.must_be_instance_of Array
      rider_trips.length.must_equal 3
    end

    it "Retrieves list of all previous drivers for trips associated with given rider" do
      rider_trips = RideShare::Rider.find("296")
      drivers_for_rider = rider_trips.drivers
      drivers_for_rider.must_be_instance_of Array
      drivers_for_rider.length.must_equal 3
      drivers_for_rider[0].must_equal "87"
    end
  end

  describe "self.all method" do
    it "Retrieves list of all riders from CSV file" do
      all_riders = RideShare::Rider.all
      all_riders.must_be_instance_of Array, "This is not an array"
      all_riders.length.must_equal 301
    end
  end

  describe "self.find method" do
    it "finds a specific rider given their rider ID" do
      RideShare::Rider.find("1").name.must_equal "Nina Hintz Sr."
    end

    it "Finds the last driver in the database" do
      # skip
      if RideShare::Rider.all[-1].rider_id == "300"
        RideShare::Rider.find("300").name.must_equal "Miss Isom Gleason"
      end
    end

    it "Raises ArgumentError if no rider is found that matches argument given" do
      proc {
        RideShare::Rider.find("1000")
      }.must_raise ArgumentError
    end
  end
end
