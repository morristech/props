import React from 'react';
import TestUtils from 'react-addons-test-utils';
import ReactCSSTransitionGroup from 'react-addons-css-transition-group';
import expect from 'expect';

import Announcement from './announcement';

const props = {
  propsCount: '9001',
};

describe('announcement', () => {
  const component = TestUtils.renderIntoDocument(<Announcement {...props}/>);

  it('renders', () => {
    expect(TestUtils.findRenderedComponentWithType(component, Announcement)).toExist();
  });

  it('is animated', () => {
    expect(TestUtils.findRenderedComponentWithType(component, ReactCSSTransitionGroup)).toExist();
  });

  it('fully shows after 500 miliseconds', () => {
    const animation = TestUtils.findRenderedComponentWithType(component, ReactCSSTransitionGroup);
    expect(animation.props.transitionAppearTimeout).toEqual(500);
  });

  it('hides after 1000 miliseconds', () => {
    const animation = TestUtils.findRenderedComponentWithType(component, ReactCSSTransitionGroup);
    expect(animation.props.transitionLeaveTimeout).toEqual(1000);
  });

  it('displays text with props count', () => {
    const element = TestUtils.findRenderedDOMComponentWithTag(component, 'p');
    expect(element.textContent).toEqual('We have 9001 props so far!');
  });
});
