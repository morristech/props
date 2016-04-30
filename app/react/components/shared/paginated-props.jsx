import React, { PropTypes } from 'react';

import PropComponent from '../props/prop';
import Pagination from '../shared/react-paginate';

export default class PaginatedProps extends React.Component {
  static get propTypes() {
    return {
      props: PropTypes.array.isRequired,
      totalPages: PropTypes.number.isRequired,
      currentPage: PropTypes.number.isRequired,
      onClickPage: PropTypes.func.isRequired,
    };
  }

  renderProps(props) {
    return props.map(prop =>
      <PropComponent key={prop.id} prop={prop} />
    );
  }

  render() {
    const { props, totalPages, currentPage, onClickPage } = this.props;

    return (
      <div>
        <Pagination
          totalPages={totalPages}
          currentPage={currentPage}
          onPageChange={onClickPage}
        />

        <ul className="list-unstyled">
          <div className="col-xs-12">
            {this.renderProps(props)}
          </div>
        </ul>

        <Pagination
          totalPages={totalPages}
          currentPage={currentPage}
          onPageChange={onClickPage}
        />

      </div>
    );
  }
}
