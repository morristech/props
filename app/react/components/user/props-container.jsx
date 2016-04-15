import React, { PropTypes } from 'react';
import { connect } from 'react-redux';
import isEmpty from 'lodash/isEmpty';

import { fetchUser, fetchUserProps, fetchUserGivenProps } from '../../actions/index.js';
import PropsStats from './props-stats';
import GivenProps from './given-props';
import ReceivedProps from './received-props';


class PropsContainer extends React.Component {
  static get propTypes() {
    const { string, object, shape, number, bool, func } = PropTypes;

    return {
      dispatch: PropTypes.func.isRequired,
      params: PropTypes.shape({
        userId: PropTypes.string.isRequired,
      }),
      userName: string,
      givenProps: object,
      receivedProps: object,
      archived: bool,
      meta: shape({
        givenCount: number,
        receivedCount: number,
      }),
      onChangePageReceived: func.isRequired,
      onChangePageGiven: func.isRequired,
    };
  }

  constructor(props) {
    super(props);
    this.onClickReceivedPage = this.onClickReceivedPage.bind(this);
    this.onClickGivenPage = this.onClickGivenPage.bind(this);
  }

  componentDidMount() {
    const { dispatch } = this.props;
    const { userId } = this.props.params;
    dispatch(fetchUser(userId));
    dispatch(fetchUserProps(userId));
    dispatch(fetchUserGivenProps(userId));
  }

  onClickReceivedPage({ selected }) {
    const { userId } = this.props.params;
    this.props.onChangePageReceived(userId, selected + 1);
  }

  onClickGivenPage({ selected }) {
    const { userId } = this.props.params;
    this.props.onChangePageGiven(userId, selected + 1);
  }

  wrapWithLoader(isAsyncLoaded, component) {
    if (isAsyncLoaded) {
      return component;
    }
    return (<div className="loading" />);
  }

  render() {
    const { userName, archived, meta, receivedProps, givenProps } = this.props;

    if (!userName || isEmpty(givenProps) || isEmpty(receivedProps)) {
      return (
        <div className="loading" />
      );
    }

    return (
      <div>
        <PropsStats
          userName={userName}
          propsReceivedCount={meta.receivedCount}
          propsGivenCount={meta.givenCount}
          archived={archived}
        />

        <ReceivedProps
          props={receivedProps.props}
          totalPages={receivedProps.meta.total_pages}
          currentPage={receivedProps.meta.current_page}
          onClickPage={this.onClickReceivedPage}
        />

        <GivenProps
          props={givenProps.props}
          totalPages={givenProps.meta.total_pages}
          currentPage={givenProps.meta.current_page}
          onClickPage={this.onClickGivenPage}
        />
      </div>
    );
  }
}

const mapStateToProps = (state) => {
  const propsCount = state.user.props_count || {};

  return {
    receivedProps: state.props.user_received_props,
    givenProps: state.props.user_given_props,
    userName: state.user.name,
    archived: state.user.archived,
    meta: {
      receivedCount: propsCount.received || 0,
      givenCount: propsCount.given || 0,
    },
  };
};

const mapDispatchToProps = (dispatch) => ({
  onChangePageReceived: (userId, selectedPage) => {
    dispatch(fetchUserProps(userId, selectedPage));
  },
  onChangePageGiven: (userId, selectedPage) => {
    dispatch(fetchUserGivenProps(userId, selectedPage));
  },
  dispatch,
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(PropsContainer);
