import React from 'react/addons';
const TestUtils = React.addons.TestUtils;
import expect from 'expect';
import Pagination from './pagination';

describe('shared/pagination', () => {
  const onPrevePageClick = expect.createSpy();
  const onNextPageClick = expect.createSpy();

  const component = TestUtils.renderIntoDocument(
    <Pagination
      hasNextPage={true}
      hasPreviousPage={true}
      onPrevPageClick={onPrevePageClick}
      onNextPageClick={onNextPageClick}
      currentPage={2}
    />
  );

  it('renders', () => {
    expect(TestUtils.findRenderedComponentWithType(component, Pagination)).toExist();
  });

  it('displays current page button', () => {
    const element = TestUtils
      .findRenderedDOMComponentWithClass(component, 'current-page')
      .getDOMNode();
    expect(element.firstChild.textContent).toEqual(2);
  });

  describe('preview page button', () => {
    it('runs passed onPrevPageClick handler when clicked', () => {
      const element = TestUtils.findRenderedDOMComponentWithClass(component, 'previous-page').getDOMNode();
      React.addons.TestUtils.Simulate.click(element);
      expect(onPrevePageClick).toHaveBeenCalled();
    });

    describe('when hasPreviousPage flag is false', () => {
      const componentWithNoPrev = TestUtils.renderIntoDocument(
        <Pagination
          hasNextPage={true}
          hasPreviousPage={false}
          onPrevPageClick={onPrevePageClick}
          onNextPageClick={onNextPageClick}
          currentPage={2}
        />
      );
      it('is not visible', () => {
        expect(() => {
          TestUtils.findRenderedDOMComponentWithClass(componentWithNoPrev, 'previous-page');
        }).toThrow('Did not find exactly one match (found: 0) for class:previous-page');
      });
    });
  });

  describe('next page button', () => {
    it('runs passed onNextPageClick handler when prev page clicked', () => {
      const element = TestUtils.findRenderedDOMComponentWithClass(component, 'next-page').getDOMNode();
      React.addons.TestUtils.Simulate.click(element);
      expect(onNextPageClick).toHaveBeenCalled();
    });

    describe('when hasNextPage flag is false', () => {
      const componentWithNoPrev = TestUtils.renderIntoDocument(
        <Pagination
          hasNextPage={false}
          hasPreviousPage={true}
          onPrevPageClick={onPrevePageClick}
          onNextPageClick={onNextPageClick}
          currentPage={2}
        />
      );
      it('is not visible', () => {
        expect(() => {
          TestUtils.findRenderedDOMComponentWithClass(componentWithNoPrev, 'next-page');
        }).toThrow('Did not find exactly one match (found: 0) for class:next-page');
      });
    });
  });
});
