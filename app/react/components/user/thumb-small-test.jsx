import React from 'react';
import TestUtils from 'react-addons-test-utils';
import expect from 'expect';

import Thumb from './thumb-small';

const userData = {
  id: 1,
  avatar_url: 'https://test1.img',
  name: 'name',
};

describe('user/thumb-small', () => {
  const component = TestUtils.renderIntoDocument(<Thumb user={userData}/>);

  it('renders', () => {
    expect(TestUtils.findRenderedComponentWithType(component, Thumb)).toExist();
  });

  it('displays user avatar', () => {
    const element = TestUtils.findRenderedDOMComponentWithTag(component, 'img');
    expect(element.getAttribute('src')).toEqual('https://test1.img');
  });

  it('links to user page', () => {
    const element = TestUtils.findRenderedDOMComponentWithTag(component, 'a');
    expect(element.getAttribute('href')).toEqual('#users/1');
  });
});
