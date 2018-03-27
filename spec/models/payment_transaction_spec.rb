require 'spec_helper'

describe PaymentTransaction do
  it "expect state transfer" do
    tx = create(:payment_transaction, deposit: create(:deposit))
    tx.stubs(:refresh_confirmations)

    tx.stubs(:min_confirm?).returns(false)
    tx.stubs(:max_confirm?).returns(false)

    expect(tx.unconfirm?).to be_truthy
    expect(tx.check).to be_falsey
    expect(tx.check).to be_falsey
    expect(tx.check).to be_falsey
    expect(tx.unconfirm?).to be_truthy

    tx.stubs(:min_confirm?).returns(true)
    tx.stubs(:max_confirm?).returns(false)

    expect(tx.check).to be_truthy
    expect(tx.confirming?).to be_truthy

    tx.stubs(:min_confirm?).returns(false)
    tx.stubs(:max_confirm?).returns(true)

    expect(tx.check).to be_truthy
    expect(tx.confirmed?).to be_truthy
    expect(tx.check).to be_truthy
  end

end
