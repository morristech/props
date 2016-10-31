import React from 'react';

export default class Pagination extends React.Component {
  static get propTypes() {
    return {
      hasNextPage: React.PropTypes.bool.isRequired,
      hasPreviousPage: React.PropTypes.bool.isRequired,
      onPrevPageClick: React.PropTypes.func.isRequired,
      onNextPageClick: React.PropTypes.func.isRequired,
      currentPage: React.PropTypes.number,
    };
  }

  render() {
    const prevButton = (
      <li>
        <a
          className="previous-page"
          href="previous-page"
          onClick={this.props.onPrevPageClick}
        >
            Previous
        </a>
      </li>
    );
    const nextButton = (
      <li>
        <a className="next-page" href="next-page" onClick={this.props.onNextPageClick}>Next</a>
      </li>
    );

    return (
      <nav>
        <ul className="pagination">
          {this.props.hasPreviousPage ? prevButton : null}
          <li className="current-page">
            <a href="current-page">{this.props.currentPage}</a>
          </li>
          {this.props.hasNextPage ? nextButton : null}
        </ul>
      </nav>
    );
  }
}
