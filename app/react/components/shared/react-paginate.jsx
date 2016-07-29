import React, { PropTypes } from 'react';
import ReactPaginate from 'react-paginate';

export default class Pagination extends React.Component {

  static get propTypes() {
    const { func, number } = PropTypes;
    return {
      onPageChange: func.isRequired,
      currentPage: number,
      totalPages: number,
    };
  }

  render() {
    const { totalPages, currentPage, onPageChange } = this.props;
    var forceSelected = currentPage - 1;
    return (
      <nav>
        <ReactPaginate
          previousLabel={Pagination.previousLabel}
          nextLabel={Pagination.nextLabel}
          breakLabel={Pagination.breakLabel}
          pageNum={totalPages}
          forceSelected={forceSelected}
          marginPagesDisplayed={Pagination.marginPagesDisplayed}
          pageRangeDisplayed={Pagination.pageRangeDisplayed}
          clickCallback={onPageChange}
          containerClassName={Pagination.containerClassName}
          subContainerClassName={Pagination.subContainerClassName}
          activeClassName={Pagination.activeClassName}
        />
      </nav>
    );
  }
}

Object.defineProperty(Pagination, 'previousLabel', { value: 'previous' });
Object.defineProperty(Pagination, 'nextLabel', { value: 'next' });
Object.defineProperty(Pagination, 'breakLabel', { value: <a href="">...</a> });
Object.defineProperty(Pagination, 'marginPagesDisplayed', { value: 2 });
Object.defineProperty(Pagination, 'pageRangeDisplayed', { value: 5 });
Object.defineProperty(Pagination, 'containerClassName', { value: 'pagination' });
Object.defineProperty(Pagination, 'subContainerClassName', { value: 'pages pagination' });
Object.defineProperty(Pagination, 'activeClassName', { value: 'active' });
