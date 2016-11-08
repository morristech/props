import React, { Component } from 'react';
import Pagination from '../Shared/Pagination';
import styles from './style.css';

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
      <div className={styles.main}>
        <h1>Props List View</h1>
        {
          this.props.propsList.map(prop =>
            <div>
              <h2>{prop.body}</h2>
              Propser: <strong>{prop.propser.name}</strong>
              <hr />
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
