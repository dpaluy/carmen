require 'spec_helper'

describe Carmen::Country do

  describe "all" do
    before do
      @countries = countries = Carmen::Country.all
    end

    it "provides access to all countries" do
      @countries.size.must_equal 3
    end

    it "denies modification of countries" do
      assert_raises RuntimeError do
        @countries.clear
      end
    end
  end

  describe "API for finding countries by name" do
    it "provides exact matching" do
      eastasia = Carmen::Country.named('Eastasia')
      eastasia.instance_of?(Carmen::Country).must_equal true
    end

    it "provides case-insensitive searches by default" do
      eurasia = Carmen::Country.named('eUrAsIa')
      eurasia.instance_of?(Carmen::Country).must_equal true
      eurasia.name.must_equal 'Eurasia'
    end

    it "provides case-sensitive searches optionally" do
      oceania = Carmen::Country.named('oCeAnIa', :case => true)
      assert_nil(oceania)
      oceania = Carmen::Country.named('Oceania', :case => true)
      oceania.instance_of?(Carmen::Country).must_equal true
      oceania.name.must_equal 'Oceania'
    end

    it "provides fuzzy (substring) matching optionally" do
      eastasia = Carmen::Country.named('East', :fuzzy => true)
      eastasia.instance_of?(Carmen::Country).must_equal true
      eastasia.name.must_equal 'Eastasia'
    end
  end

  describe '#continent' do
    it 'provides access to the continent it belongs to' do
      Carmen::Country.coded('OC').continent.must_equal Carmen::Continent.coded('004')
    end
  end

  describe 'API for finding countries by code' do
    describe 'Universal finder method' do
      it 'provides an API for finding countries by 2-symbol code' do
        eurasia = Carmen::Country.coded('EU')
        eurasia.instance_of?(Carmen::Country).must_equal true
        eurasia.name.must_equal 'Eurasia'
      end

      it 'provides an API for finding countries by 3-symbol code' do
        eastasia = Carmen::Country.coded('EST')
        eastasia.instance_of?(Carmen::Country).must_equal true
        eastasia.name.must_equal 'Eastasia'
      end

      it 'provides an API for finding countries by numeric code' do
        oceania = Carmen::Country.coded('001')
        oceania.instance_of?(Carmen::Country).must_equal true
        oceania.name.must_equal 'Oceania'
      end
    end

    describe 'Finder methods for searching by each attribute' do
      it 'provides an API for finding countries by 2-symbol code' do
        eurasia = Carmen::Country.alpha_2_coded('EU')
        eurasia.instance_of?(Carmen::Country).must_equal true
        eurasia.name.must_equal 'Eurasia'
      end

      it 'provides an API for finding countries by 3-symbol code' do
        eastasia = Carmen::Country.alpha_3_coded('EST')
        eastasia.instance_of?(Carmen::Country).must_equal true
        eastasia.name.must_equal 'Eastasia'
      end

      it 'provides an API for finding countries by numeric code' do
        oceania = Carmen::Country.numeric_coded('001')
        oceania.instance_of?(Carmen::Country).must_equal true
        oceania.name.must_equal 'Oceania'
      end
    end
  end

  describe "basic attributes" do
    before do
      @oceania = Carmen::Country.coded('OC')
    end

    it "is of type :country" do
      @oceania.type.must_equal 'country'
    end

    it "has a name" do
      @oceania.name.must_equal 'Oceania'
    end

    it "has an official name" do
      @oceania.official_name.must_equal 'The Superstate of Oceania'
    end
    it "has a common name" do
      @oceania.common_name.must_equal 'Oceania'
    end

    it "has a 2 character code" do
      @oceania.alpha_2_code.must_equal 'OC'
    end

    it "has a 3 character code" do
      @oceania.alpha_3_code.must_equal 'OCE'
    end

    it "has code as an alias to alpha_2_code" do
      @oceania.code.must_equal 'OC'
    end

    it "has a numeric code" do
      @oceania.numeric_code.must_equal '001'
    end

    it "has the world as a parent" do
      @oceania.parent.must_equal Carmen::World.instance
    end

    it 'has a reasonable inspect value' do
      @oceania.inspect.must_equal '<#Carmen::Country name="Oceania">'
    end
  end


end
