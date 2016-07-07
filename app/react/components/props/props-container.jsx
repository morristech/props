import React, { PropTypes } from 'react';
import { connect } from 'react-redux';
import isEmpty from 'lodash/isEmpty';

import { fetchProps } from '../../actions/index';

import PaginatedProps from '../shared/paginated-props';
import PropsForm from './props-form';

class PropsContainer extends React.Component {
  static get propTypes() {
    return {
      props: PropTypes.object,
      dispatch: PropTypes.func.isRequired,
    };
  }

  constructor(props) {
    super(props);
    this.onClickPage = this.onClickPage.bind(this);
  }

  componentDidMount() {
    const { dispatch } = this.props;
    const page = 1;
    dispatch(fetchProps(page));
  }

  onClickPage({ selected }) {
    const { dispatch } = this.props;
    dispatch(fetchProps(selected + 1));
  }

  render() {
    const { props } = this.props;

    if (isEmpty(props)) {
      return (<div className="loading" />);
    }

    return (
      <div>
        <PropsForm />
        <PaginatedProps
          props={props.props}
          totalPages={props.meta.total_pages}
          currentPage={props.meta.current_page}
          onClickPage={this.onClickPage}
        />
      </div>
    );
  }
}

const mapStateToProps = (state) => ({
  props: state.props.props,
});

export default connect(
  mapStateToProps
)(PropsContainer);
