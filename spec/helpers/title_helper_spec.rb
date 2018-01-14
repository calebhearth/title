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

  it 'uses a :default key at an arbitrary point in the lookup path' do
    stub_rails
    stub_controller_and_action('engine/users', :show)
    load_translations(engine: { default: 'Engine name' })

    expect(helper.title).to eq 'Engine name'
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
    allow(helper).to receive_message_chain(:controller, :view_assigns).and_return('name' => 'Caleb')

    expect(helper.title).to eq('Caleb')
  end

  it 'can accept a hash of extra context in addition to the view assigns' do
    stub_rails
    stub_controller_and_action(:users, :show)
    load_translations(users: { show: '%{greeting} %{name}' })
    allow(helper).to receive_message_chain(:controller, :view_assigns).and_return('name' => 'Caleb')

    expect(helper.title(greeting: 'Hello')).to eq('Hello Caleb')
  end

  it 'makes context safe to be passed as interpolation options' do
    stub_rails
    stub_controller_and_action(:users, :show)
    load_translations(users: { show: 'User' })
    allow(helper).to receive_message_chain(:controller, :view_assigns).and_return('scope' => 'Foo')

    expect(helper.title).to eq('User')
  end

  def stub_rails
    allow(helper).to receive(:controller_path).and_return('dashboards')
    allow(helper).to receive(:action_name)
    allow(helper).to receive_message_chain(:controller, :view_assigns).and_return({})
    allow(Rails).to receive_message_chain(:application, :class).and_return('Dummy::Application')
  end

  def stub_controller_and_action(controller, action)
    allow(helper).to receive(:controller_path).and_return(controller.to_s)
    allow(helper).to receive(:action_name).and_return(action.to_s)
  end

  def helper
    @helper ||= Class.new { include Title::TitleHelper }.new
  end

  def load_translations(titles)
    I18n.backend.store_translations(:en, { titles: titles })
  end
end
