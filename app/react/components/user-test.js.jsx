import React from 'react/addons';
const TestUtils = React.addons.TestUtils;
import expect from 'expect';
import User from './user';

const userData = {
  id: 1,
  avatar_url: 'https://test1.img',
  name: 'name',
};

describe('Users', () => {
  const component = TestUtils.renderIntoDocument(<User user={userData}/>);

  it('renders', () => {
    expect(TestUtils.findRenderedComponentWithType(component, User)).toExist();
  });
});
