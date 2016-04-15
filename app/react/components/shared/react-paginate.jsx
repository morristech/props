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

    return (
      <nav>
        <ReactPaginate
          previousLabel={"previous"}
          nextLabel={"next"}
          breakLabel={<a href="">...</a>}
          pageNum={totalPages}
          forceSelected={currentPage - 1}
          marginPagesDisplayed={2}
          pageRangeDisplayed={5}
          clickCallback={onPageChange}
          containerClassName={"pagination"}
          subContainerClassName={"pages pagination"}
          activeClassName={"active"}
        />
      </nav>
    );
  }
}
