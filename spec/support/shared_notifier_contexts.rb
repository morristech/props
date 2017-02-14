shared_examples "OneSignal::Notification.create called once" do
  it "triggers OneSignal::Notification.create once with correct arguments" do
    expect(OneSignal::Notification).to receive(:create).with(params: params).once
    subject
  end
end
