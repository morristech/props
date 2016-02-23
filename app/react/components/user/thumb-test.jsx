import React from 'react';
import TestUtils from 'react-addons-test-utils';
import expect from 'expect';

import UserThumb from './thumb';

const props = {
  id: 1,
  avatarUrl: 'https://test1.img',
  name: 'user name',
};

describe('user/thumb', () => {
  const component = TestUtils.renderIntoDocument(<UserThumb {...props}/>);

  it('renders', () => {
    expect(TestUtils.findRenderedComponentWithType(component, UserThumb)).toExist();
  });

  it('links to user page', () => {
    const element = TestUtils.findRenderedDOMComponentWithClass(component, 'user-card');
    expect(element.getAttribute('href')).toEqual('#users/1');
  });

  it('displays user avatar', () => {
    const element = TestUtils.findRenderedDOMComponentWithTag(component, 'img');
    expect(element.getAttribute('src')).toEqual('https://test1.img');
  });
});
