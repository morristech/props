/* eslint-disable no-unused-expressions */
import React from 'react';
import chaiEnzyme from 'chai-enzyme';
import { shallow } from 'enzyme';
import chai, { expect } from 'chai';
import ThumbSmall from '../ThumbSmall';

jest.unmock('../ThumbSmall');
chai.use(chaiEnzyme());

const userObject = {
  id: 1,
  avatar_url: 'https://test1.img',
  name: 'name',
};

const component = shallow(
  <ThumbSmall userObject={userObject} />
);

describe('<ThumbSmall />', () => {
  it('renders', () => {
    expect(component).to.exist;
  });

  it('links to user page', () => {
    const url = `#users/${userObject.id}`;
    expect(component.find({ href: url })).to.exist;
  });

  it('displays user avatar', () => {
    const element = component.find({ src: userObject.avatar_url });
    expect(element).to.exist;
  });
});
