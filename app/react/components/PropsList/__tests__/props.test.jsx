/* eslint-disable no-unused-expressions */
import React from 'react';
import chaiEnzyme from 'chai-enzyme';
import { shallow } from 'enzyme';
import chai, { expect } from 'chai';
import PropsList from '../index';

jest.unmock('../index');
chai.use(chaiEnzyme());

const mockPageHandler = () => {};

const wrapper = shallow(
  <PropsList
    propsList={[]}
    hasPrevPage
    hasNextPage
    onPaginationPrev={mockPageHandler}
    onPaginationNext={mockPageHandler}
    currentPage={2}
  />
);

describe('<Pagination />', () => {
  it('renders', () => {
    expect(wrapper).to.exist;
  });
});
