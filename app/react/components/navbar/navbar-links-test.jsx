import React from 'react';
import TestUtils from 'react-addons-test-utils';
import expect from 'expect';

import NavbarLinks from './navbar-links';

const props = {
  links: [
    {url: 'http://example.com', name: 'example'},
    {url: 'http://example.com/test', name: 'test'},
  ],
};

const component = TestUtils.renderIntoDocument(<NavbarLinks {...props}/>);

describe('navbar/navbar-links', () => {
  it('renders', () => {
    expect(TestUtils.findRenderedComponentWithType(component, NavbarLinks)).toExist();
  });

  it('creates a list with links', () => {
    const links = TestUtils.scryRenderedDOMComponentsWithTag(component, 'a');
    expect(links.length).toEqual(2);
  });

  it('properly creates link tag', () => {
    const link = TestUtils.scryRenderedDOMComponentsWithTag(component, 'a')[0];

    expect(link.textContent).toEqual('example');
    expect(link.href).toEqual('http://example.com/');
  });
});
