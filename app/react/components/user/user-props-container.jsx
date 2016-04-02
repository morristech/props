import React, { PropTypes } from 'react';
import { connect } from 'react-redux';

import { fetchUser, fetchUserProps, fetchUserGivenProps } from '../../actions/index.js';
import UserProps from './user-props';

class UserPropsContainer extends React.Component {
  static get propTypes() {
    return {
      dispatch: PropTypes.func.isRequired,
      userId: PropTypes.string.isRequired,
    };
  }

  componentDidMount() {
    const { dispatch, userId } = this.props;
    dispatch(fetchUser(userId));
    dispatch(fetchUserProps(userId));
    dispatch(fetchUserGivenProps(userId));
  }

  render() {
    return (
      <UserProps {...this.props} />
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

export default connect(
  mapStateToProps
)(UserPropsContainer);
