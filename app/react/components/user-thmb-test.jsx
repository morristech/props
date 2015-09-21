import React from 'react/addons';
const TestUtils = React.addons.TestUtils;
import expect from 'expect';
import UserThumb from './user-thumb';

const props = {
  id: 1,
  avatarUrl: 'https://test1.img',
  name: 'user name',
};

describe('userThumb', () => {
  const component = TestUtils.renderIntoDocument(<UserThumb {...props}/>);

  it('renders', () => {
    expect(TestUtils.findRenderedComponentWithType(component, UserThumb)).toExist();
  });

  it('links to user page', () => {
    const element = TestUtils.findRenderedDOMComponentWithClass(component, 'user-card').getDOMNode();
    expect(element.getAttribute('href')).toEqual('#users/1');
  });

  it('displays user avatar', () => {
    const element = TestUtils.findRenderedDOMComponentWithTag(component, 'img').getDOMNode();
    expect(element.getAttribute('src')).toEqual('https://test1.img');
  });
});
