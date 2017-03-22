/* eslint-disable no-unused-expressions */
import React from 'react';
import chaiEnzyme from 'chai-enzyme';
import { shallow } from 'enzyme';
import chai, { expect } from 'chai';
import Thumb from '../Thumb';

jest.unmock('../index');
chai.use(chaiEnzyme());

const props = {
  id: 1,
  avatarUrl: 'https://test1.img',
  name: 'user name',
};

const component = shallow(
  <Thumb {...props} />
);

describe('<Thumb />', () => {
  it('renders', () => {
    expect(component).to.exist;
  });

  it('links to user page', () => {
    const url = `#users/${props.id}`;
    expect(component.find({ href: url })).to.exist;
  });

  it('displays user avatar', () => {
    const element = component.find({ src: props.avatarUrl });
    expect(element).to.exist;
  });
});
