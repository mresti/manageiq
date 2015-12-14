describe ChargebackRateDetail do
  it "#cost" do
    cvalue   = 42.0
    fix_rate = 5.0
    var_rate = 8.26
    tier_start = -Float::INFINITY
    tier_end = Float::INFINITY
    per_time = 'monthly'
    per_unit = 'megabytes'
    cbd = FactoryGirl.build(:chargeback_rate_detail,
                             :per_time => per_time,
                             :per_unit => per_unit,
                             :enabled  => true)
    FactoryGirl.create(:chargeback_tier,
                       :chargeback_rate_detail_id => cbd.id,
                       :start                     => tier_start,
                       :end                       => tier_end,
                       :fix_rate                  => fix_rate,
                       :var_rate                  => var_rate)
    expect(cbd.cost(cvalue)).to eq(cvalue * cbd.hourly_rate + cbd.hourly(fix_rate))

    cbd.group = 'fixed'
    expect(cbd.cost(cvalue)).to eq(cbd.hourly_rate + cbd.hourly(fix_rate))

    cbd.enabled = false
    expect(cbd.cost(cvalue)).to eq(0.0)
  end

  it "#hourly_rate" do
    [
      0,
      0.0,
      0.00
    ].each do |rate|
      cbd = FactoryGirl.build(:chargeback_rate_detail)
      FactoryGirl.create(:chargeback_tier, :chargeback_rate_detail_id => cbd.id, :start => -Float::INFINITY,
                         :end => Float::INFINITY, :var_rate => rate, :fix_rate => 0.0)
      expect(cbd.hourly_rate).to eq(0.0)
    end
    cbdm = FactoryGirl.create(:chargeback_rate_detail_measure_bytes)
    rate = 8.26
    [
      'hourly',   'megabytes',  rate,
      'daily',    'megabytes',  rate / 24,
      'weekly',   'megabytes',  rate / 24 / 7,
      'monthly',  'megabytes',  rate / 24 / 30,
      'yearly',   'megabytes',  rate / 24 / 365,
      'yearly',   'gigabytes',  rate / 24 / 365 / 1024,
    ].each_slice(3) do |per_time, per_unit, hourly_rate|
      cbd = FactoryGirl.build(:chargeback_rate_detail,
                               :per_time                          => per_time,
                               :per_unit                          => per_unit,
                               :metric                            => 'derived_memory_available',
                               :chargeback_rate_detail_measure_id => cbdm.id
                              )
      cbt = FactoryGirl.create(:chargeback_tier, :chargeback_rate_detail_id => cbd.id, :start => -Float::INFINITY,
                               :end => Float::INFINITY, :var_rate => rate, :fix_rate => 0.0)
      cbd.update(:chargeback_tiers => [cbt])
      expect(cbd.hourly_rate).to eq(hourly_rate)
    end

    cbd = FactoryGirl.build(:chargeback_rate_detail, :per_time => 'annually')
    cbt = FactoryGirl.create(:chargeback_tier, :chargeback_rate_detail_id => cbd.id, :start => -Float::INFINITY,
                             :end => Float::INFINITY, :var_rate => rate, :fix_rate => 0.0)
    cbd.update(:chargeback_tiers => [cbt])
    expect  { cbd.hourly_rate }.to raise_error(RuntimeError, "rate time unit of 'annually' not supported")
  end

  it "#rate_adjustment" do
    value = 10.gigabytes
    cbdm = FactoryGirl.create(:chargeback_rate_detail_measure_bytes)
    [
      'megabytes', value,
      'gigabytes', value / 1024,
    ].each_slice(2) do |per_unit, rate_adjustment|
      cbd = FactoryGirl.build(:chargeback_rate_detail, :per_unit => per_unit, :metric => 'derived_memory_available',
       :chargeback_rate_detail_measure_id => cbdm.id)
      expect(cbd.rate_adjustment(value)).to eq(rate_adjustment)
    end
  end

  it "#rate_name" do
    source = 'used'
    group  = 'cpu'
    cbd = FactoryGirl.build(:chargeback_rate_detail, :source => source, :group => group)
    expect(cbd.rate_name).to eq("#{group}_#{source}")
  end

  it "#friendly_rate" do
    friendly_rate = "My Rate"
    cbd = FactoryGirl.build(:chargeback_rate_detail, :friendly_rate => friendly_rate)
    expect(cbd.friendly_rate).to eq(friendly_rate)

    cbd = FactoryGirl.build(:chargeback_rate_detail, :group => 'fixed', :per_time => 'monthly')
    FactoryGirl.create(:chargeback_tier, :start => -Float::INFINITY, :chargeback_rate_detail_id =>  cbd.id,
                       :end => Float::INFINITY, :fix_rate => 1.0, :var_rate => 2.0)
    expect(cbd.friendly_rate).to eq("3.0 Monthly")

    cbd = FactoryGirl.build(:chargeback_rate_detail, :per_unit => 'cpu', :per_time => 'monthly')
    cbt = FactoryGirl.create(:chargeback_tier, :start => -Float::INFINITY, :chargeback_rate_detail_id => cbd.id,
                             :end => Float::INFINITY, :fix_rate => 1.0, :var_rate => 2.0)
    cbd.update(:chargeback_tiers => [cbt])
    expect(cbd.friendly_rate).to eq("Monthly @ 1.0 + 2.0 per Cpu from -Infinity to Infinity")

    cbd = FactoryGirl.build(:chargeback_rate_detail, :per_unit => 'megabytes', :per_time => 'monthly')
    cbt1 = FactoryGirl.create(:chargeback_tier, :start => -Float::INFINITY, :chargeback_rate_detail_id => cbd.id,
                             :end => 0.0, :fix_rate => 0.0, :var_rate => 0.0)
    cbt2 = FactoryGirl.create(:chargeback_tier, :start => 0.0, :chargeback_rate_detail_id => cbd.id,
                             :end => 5.0, :fix_rate => 1.0, :var_rate => 2.0)
    cbt3 = FactoryGirl.create(:chargeback_tier, :start => 5.0, :chargeback_rate_detail_id => cbd.id,
                             :end => Float::INFINITY, :fix_rate => 5.0, :var_rate => 2.5)
    cbd.update(:chargeback_tiers => [cbt1, cbt2, cbt3])
    expect(cbd.friendly_rate).to eq("Monthly @ 0.0 + 0.0 per Megabytes from -Infinity to 0.0\n\
Monthly @ 1.0 + 2.0 per Megabytes from 0.0 to 5.0\n\
Monthly @ 5.0 + 2.5 per Megabytes from 5.0 to Infinity"
  end

  it "#per_unit_display_without_measurements" do
    [
      'cpu',       'Cpu',
      'ohms',      'Ohms'
    ].each_slice(2) do |per_unit, per_unit_display|
      cbd = FactoryGirl.build(:chargeback_rate_detail, :per_unit => per_unit)
      expect(cbd.per_unit_display).to eq(per_unit_display)
    end
  end

  it "#per_unit_display_with_measurements" do
    cbdm = FactoryGirl.create(:chargeback_rate_detail_measure_bytes)
    cbd  = FactoryGirl.build(:chargeback_rate_detail,
                             :per_unit                          => 'megabytes',
                             :chargeback_rate_detail_measure_id => cbdm.id)
    expect(cbd.per_unit_display).to eq('MB')
  end

  it "#rate_type" do
    cbd = FactoryGirl.build(:chargeback_rate_detail)
    expect(cbd.rate_type).to be_nil

    rate_type = 'ad-hoc'
    cb = FactoryGirl.create(:chargeback_rate, :rate_type => rate_type)
    cbd.chargeback_rate = cb
    expect(cbd.rate_type).to eq(rate_type)
  end

  it "is valid without per_unit, metric and measure" do
    %w(
      'cpu' 'derived_vm_numvcpus' nil,
      nil   nil                   nil)
      .each_slice(3) do |per_unit, metric, chargeback_rate_detail_measure_id|
        cbd = FactoryGirl.build(:chargeback_rate_detail,
                                :per_unit                          => per_unit,
                                :metric                            => metric,
                                :chargeback_rate_detail_measure_id => chargeback_rate_detail_measure_id)
        cbt = FactoryGirl.create(:chargeback_tier,
                                 :chargeback_rate_detail_id => cbd.id,
                                 :start                     => -Float::INFINITY,
                                 :end                       => Float::INFINITY,
                                 :fix_rate                  => 0.0,
                                 :var_rate                  => 0.0)
        cbd.update(:chargeback_tiers => [cbt])
        expect(cbd).to be_valid
      end
  end

  it "diferents_per_units_rates_should_have_the_same_cost" do
    cbdm = FactoryGirl.create(:chargeback_rate_detail_measure_bytes)
    # should be the same cost. bytes to megabytes and gigabytes to megabytes
    cbd_bytes = FactoryGirl.build(:chargeback_rate_detail,
                                  :per_unit                          => 'bytes',
                                  :metric                            => 'derived_memory_available',
                                  :per_time                          => 'monthly',
                                  :chargeback_rate_detail_measure_id => cbdm.id)
    cbd_gigabytes = FactoryGirl.build(:chargeback_rate_detail,
                                      :per_unit                          => 'gigabytes',
                                      :metric                            => 'derived_memory_available',
                                      :per_time                          => 'monthly',
                                      :chargeback_rate_detail_measure_id => cbdm.id)
    expect(cbd_bytes.cost(100)).to eq(cbd_gigabytes.cost(100))
  end
end
