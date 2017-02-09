import React, { PropTypes } from 'react';
import { isEmpty } from 'lodash';
import Pagination from '../shared/pagination';
import AddProp from './AddProp';
import Prop from './Prop';

const PropsList = ({
  propsList,
  users,
  hasPrevPage,
  hasNextPage,
  onPaginationPrev,
  onPaginationNext,
  currentPage,
}) => {
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
        !isEmpty(users) && <AddProp users={users} />
      }
      {propsList.map(prop =>
        <Prop
          key={prop.id}
          prop={prop}
          voteComponent={null}
        />
      )}

      <Pagination
        hasPreviousPage={hasPrevPage}
        hasNextPage={hasNextPage}
        onPrevPageClick={handlePrevPageClick}
        onNextPageClick={handleNextPageClick}
        currentPage={currentPage}
      />
    </div>
  );
};

PropsList.propTypes = {
  propsList: PropTypes.arrayOf(PropTypes.object),
  hasPrevPage: PropTypes.bool.isRequired,
  hasNextPage: PropTypes.bool.isRequired,
  onPaginationPrev: PropTypes.func.isRequired,
  onPaginationNext: PropTypes.func.isRequired,
  currentPage: PropTypes.number.isRequired,
};

export default PropsList;
