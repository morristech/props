import React, { Component } from 'react';
import Pagination from '../Shared/Pagination';
import Prop from './Prop';

class PropsList extends Component {
  render() {
    const {
      hasPrevPage,
      hasNextPage,
      onPaginationPrev,
      onPaginationNext,
      currentPage,
    } = this.props;

    const handlePrevPageClick = (e) => {
      e.preventDefault();
      onPaginationPrev(currentPage - 1);
    };

    const handleNextPageClick = (e) => {
      e.preventDefault();
      onPaginationNext(currentPage + 1);
    };

    return (
      <div>
        {
          this.props.propsList.map(prop =>
            <div>
              <Prop
                prop={prop}
                voteComponent={null}
              />
            </div>
          )
        }
        <Pagination
          hasPreviousPage={hasPrevPage}
          hasNextPage={hasNextPage}
          onPrevPageClick={handlePrevPageClick}
          onNextPageClick={handleNextPageClick}
          currentPage={currentPage}
        />
      </div>
    );
  }
}

PropsList.propTypes = {

};

export default PropsList;
