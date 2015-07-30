import React from 'react';

class Pagination extends React.Component {
  render() {
    const prevButton = (
      <li>
        <a className="previous-page" href="#"onClick={this.props.onPrevPageClick}>Previous</a>
      </li>
    );
    const nextButton = (
      <li>
        <a className="next-page" href="#" onClick={this.props.onNextPageClick}>Next</a>
      </li>
    );

    return (
      <nav>
        <ul className="pagination">
          {this.props.hasPreviousPage ? prevButton : null}
          <li><a href="#">{this.props.currentPage}</a></li>
          {this.props.hasNextPage ? nextButton : null}
        </ul>
      </nav>
    );
  }
}

Pagination.propTypes = {
  currentPage: React.PropTypes.number.isRequired,
  hasNextPage: React.PropTypes.bool.isRequired,
  hasPreviousPage: React.PropTypes.bool.isRequired,
  onPrevPageClick: React.PropTypes.func.isRequired,
  onNextPageClick: React.PropTypes.func.isRequired,
};

export default Pagination;
