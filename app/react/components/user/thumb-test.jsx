import React from 'react';
import TestUtils from 'react-addons-test-utils';
import expect from 'expect';
import { Router, Route, createMemoryHistory } from 'react-router';

import UserThumb from './thumb';

const props = {
  id: 1,
  avatarUrl: 'https://test1.img',
  name: 'user name',
};

const history = createMemoryHistory('/');

describe('user/thumb', () => {
  const component = TestUtils.renderIntoDocument(
    <Router history={history}>
      <Route path="/" component={() => <UserThumb {...props} /> } />
    </Router>
  );

  it('renders', () => {
    expect(TestUtils.findRenderedComponentWithType(component, UserThumb)).toExist();
  });

  it('links to user page', () => {
    const element = TestUtils.findRenderedDOMComponentWithTag(component, 'a');

    expect(element.getAttribute('href')).toEqual('/app/users/1');
  });

  it('displays user avatar', () => {
    const element = TestUtils.findRenderedDOMComponentWithTag(component, 'img');
    expect(element.getAttribute('src')).toEqual('https://test1.img');
  });
});
