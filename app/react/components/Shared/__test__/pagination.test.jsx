/* eslint-disable no-unused-expressions */
import React from 'react';
import chaiEnzyme from 'chai-enzyme';
import { shallow } from 'enzyme';
import chai, { expect } from 'chai';
import Pagination from '../Pagination';

jest.unmock('../Pagination');
chai.use(chaiEnzyme());

const pageHandlerMock = () => {};

describe('<Pagination />', () => {
  it('renders', () => {
    const wrapper = shallow(
      <Pagination
        hasNextPage
        hasPreviousPage
        onPrevPageClick={pageHandlerMock}
        onNextPageClick={pageHandlerMock}
        currentPage={2}
      />
    );
    expect(wrapper).to.exist;
  });
});
