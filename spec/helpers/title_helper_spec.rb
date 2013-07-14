require 'coveralls'
Coveralls.wear!

require 'title'

describe Title::TitleHelper do
  it 'is the app name when no translation is present' do
    stub_rails

    expect(helper.title).to eq('Dummy')
  end

  it 'uses the application title by default' do
    stub_rails
    load_translations(application: 'Not Dummy')

    expect(helper.title).to eq('Not Dummy')
  end

  it 'matches controller/action to translation and uses that title' do
    stub_rails
    stub_controller_and_action(:dashboards, :show)
    load_translations(dashboards: { show: 'Dashboard' })

    expect(helper.title).to eq('Dashboard')
  end

  it 'can use view assigns' do
    stub_rails
    stub_controller_and_action(:users, :show)
    load_translations(users: { show: '%{name}' })
    helper.stub_chain(:controller, :view_assigns, :symbolize_keys).and_return({ name: 'Caleb' })

    expect(helper.title).to eq('Caleb')
  end

  def stub_rails
    helper.stub(:controller_path).and_return('dashboards')
    helper.stub(:action_name)
    helper.stub_chain(:controller, :view_assigns, :symbolize_keys).and_return({})
    Rails.stub_chain(:application, :class).and_return('Dummy::Application')
  end

  def stub_controller_and_action(controller, action)
    helper.stub(controller_path: controller.to_s, action_name: action.to_s)
  end

  def helper
    @helper ||= Class.new { include Title::TitleHelper }.new
  end

  def load_translations(titles)
    I18n.backend.store_translations(:en, { titles: titles })
  end
end
